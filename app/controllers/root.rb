Hotmess100.controllers '/' do
  register Padrino::Cache
  enable :caching

  #get :songs,:map => '/songs(/:year)', :provides => [:html, :json], :cache => true do
  #I want to cache this but padrino can't cache json at this time
  get :songs,:map => '/songs(/:year)', :provides => [:html, :json] do
    year = params[:year] || ENV['current_year']
    find_params = {conditions: {year: year}, include: 'artist', order: 'songs.name'}
    @songs = Song.all(find_params)

    case content_type
    when :html
      render 'songs/index'
    else
      @songs.to_json(:include => :artist, :methods => [:short_desc, :content_link])
    end
  end

  get :short_lists, :with => :email do
    email = params[:email] + '.' + params[:format]
    year = params[:year] || ENV['current_year']
    @short_list = ShortList.find_by_email_and_year(email, year)
    @short_list_songs = @short_list.short_listed_songs.all( :include => {:song => :artist}, :order => 'short_listed_songs.position')
    @songs = @short_list_songs.map{|sls| sls.song}
    @songs.to_json(:include => :artist, :methods => [:short_desc, :content_link])
  end

  post :short_lists, :with => :email do
    email = params[:email] + '.' + params[:format]
    year = params[:year] || ENV['current_year']
    unless params[:songs].blank?
      songs_list = params[:songs]
      unless @short_list = ShortList.find_by_email_and_year(email, year)
        @short_list = ShortList.create(email: email, year: year)
      end
      @short_list.short_list_songs(songs_list)
    end
  end

  get :about, :cache => true do
    render 'about', layout: 'static.html'
  end

  get :index, :with => :year_or_email, :cache => true do
    if params[:year_or_email] =~ /\d{4}/
      @year = params[:year_or_email]
    else
      @email = params[:year_or_email] + '.' + params[:format]
    end
    render 'songs/index'
  end

  get :index, :with => [:year, :email], :cache => true do
    @year = params[:year]
    @email = params[:email]+ '.' + params[:format]
    render 'songs/index'
  end

  get :index, :cache => true do
    render 'songs/index'
  end
end
