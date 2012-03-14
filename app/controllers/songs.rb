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

  get :index, :provides => [:html, :js] do
    @songs = Song.all(:include => :artist, :order => 'songs.name', :limit => 30)
    @song_list_json = @songs.to_json(:include => :artist, :methods => [:short_desc, :content_link])
    case content_type
    when :js then @song_list_json
    else
      render 'songs/index'
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
