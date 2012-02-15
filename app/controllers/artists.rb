Hotmess100.controllers :artists do
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
    @song= S.all(:include => :songs, :order => 'artists.name, songs.name')
    @song_list_json = @artists.to_json(:include => :songs)
    case content_type
    when :js then @song_list_json
    else
      render 'artists/index'
    end
  end

  get :year, :with => :year, :provides => [:html, :js] do
    @artists = Artist.all(:conditions => {'songs.year' => params[:year]}, :include => :songs, :order => 'artists.name, songs.name')
    case content_type
    when :js then @artists.to_json
    else
      render 'artists/artists'
    end
  end
end
