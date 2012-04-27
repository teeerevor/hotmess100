Hotmess100.controllers :songs do
  # get :index, :map => "/foo/bar" do
  #   session[:foo] = "bar"
  #   render 'index'
  # end

  # get :sample, :map => "/sample/url", :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get "/example" do
  #   "Hello world!"
  # end

  get :index, :provides => [:html, :json] do
    find_params = {:include => :artist, :order => 'songs.name'}


    if params[:page]
      limit = params[:limit].to_i
      page = params[:page].to_i
      offset = limit * page
      find_params[:limit] = limit
      find_params[:offset] = page == 0 ? 0 : offset
    end

    unless content_type == :json
      song_limit = params[:limit] || 30
      find_params[:limit] = song_limit
    end

    @songs = Song.all(find_params)
    @song_list_json = @songs.to_json(:include => :artist, :methods => [:short_desc, :content_link])

    case content_type
    when :html then render 'songs/index'
    else
      @song_list_json
    end
  end

  #get :index, :provides => [:html, :js] do
    #@songs = Song.all(:include => :artist, :order => 'name', )
    #@song_list_json = @songs.to_json(:include => :artist)
    #case content_type
    #when :js then @song_list_json
    #else
      #render 'songs/index'
    #end
  #end
end
