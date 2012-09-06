Hotmess100.controllers :short_lists do
  get :index, :with => :email do
    @short_list = ShortList.find_by_email_and_year(params[:email], Time.now.year)
    @short_list_songs = @short_list.short_listed_songs.all( :include => {:song => :artist}, :order => 'short_listed_songs.position')
    @songs = @short_list_songs.map{|sls| sls.song}
    @songs.to_json(:include => :artist, :methods => [:short_desc, :content_link])
  end

  post :index, :with => :email do
    unless params[:songs].blank?
      songs_list = params[:songs]
      unless @short_list = ShortList.find_by_email_and_year(params[:email], Time.now.year)
        @short_list = ShortList.create(email: params[:email], year: Time.now.year)
      end
      @short_list.short_list_songs(songs_list)
    end
  end
end
