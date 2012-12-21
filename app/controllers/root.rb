Hotmess100.controllers '/' do
  get :index do
    render 'songs/index'
  end

  get :songs, :provides => [:html, :json] do
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
    year = params[:year] || ENV['current_year']
    @short_list = ShortList.find_by_email_and_year(params[:email], year)
    @short_list_songs = @short_list.short_listed_songs.all( :include => {:song => :artist}, :order => 'short_listed_songs.position')
    @songs = @short_list_songs.map{|sls| sls.song}
    @songs.to_json(:include => :artist, :methods => [:short_desc, :content_link])
  end

  post :short_lists, :with => :email do
    year = params[:year] || ENV['current_year']
    unless params[:songs].blank?
      songs_list = params[:songs]
      unless @short_list = ShortList.find_by_email_and_year(params[:email], year)
        @short_list = ShortList.create(email: params[:email], year: year)
      end
      @short_list.short_list_songs(songs_list)
    end
  end

  get :about do
    render 'about', layout: 'static.html'
  end

  get :index, :with => :year_or_email do
    if params[:year_or_email] =~ /\d{4}/
      @year = params[:year_or_email]
    else
      @email = params[:year_or_email]
    end
    render 'songs/index'
  end

  get :index, :with => [:year, :email] do
    @year = params[:year]
    @email = params[:email]
    render 'songs/index'
  end
end
