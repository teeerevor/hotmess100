class window.Hotmess.Views.SongView extends Backbone.View
  tagName: 'li'
  className: 'song'

  events:
    'click .short_list_song'   : 'add_to_short_list'
    'click .short_list_to_pos' : 'add_to_short_list_at'
    'click .remove'            : 'remove_from_short_list'
    'click .song_details'      : 'toggle_song'
    'hover .song_header'       : 'toggle_song_highlight'

  initialize: ->
    @user_opened = false
    @song_open = false
    @model.bind 'open',  @open, @
    @model.bind 'close', @close, @
    @model.bind 'reset', @render, @

  render: ->
    if @model
      $(@el).html(@template(@model.toJSON()))
      if @model.get('open')
        @toggle_song()
    @

  template: (model)->
    Handlebars.registerHelper 'first_letter', (str)->
      if str then str.charAt(0) else ''
    Handlebars.registerHelper 'song_name_trim', (str)->
      if str and str.length > 37
        return str.substring(0,34) + '...'
      str
    tp = Handlebars.compile($('#song-template').html())
    tp(model)

  youtube_template: (model)->
    tp = Handlebars.compile($('#youtube-template').html())
    tp(model)

  add_to_short_list: ->
    window.shortList.add(@model)

  add_to_short_list_at: ->
    window.shortList.add(@model, {at: 0})

  remove_from_short_list: ->
    window.shortList.remove(@model)

  toggle_song: ->
    @user_opened = if @user_opened then false else true
    if @song_open then @close() else @open()

  open: ->
    $(@el).addClass('expanded')
    yt_holder = @.$('.youtube_vid')
    @load_youtube_vid(yt_holder, @model.get('youtube_url'))
    yt_holder.fitVids()
    @song_open = true

  close: ->
    unless @user_opened
      $(@el).removeClass('expanded')
      @.$('.youtube_vid').empty()
      @song_open = false


  load_youtube_vid: (yt_container, yt_vid_id) ->
    hottestPlayer.open_song(yt_vid_id, @)
    yt_container.append("<div id='#{yt_vid_id}'></div>")
    params = { allowScriptAccess: "always" }
    atts = { id: yt_vid_id }
    url = "http://www.youtube.com/v/#{yt_vid_id}?enablejsapi=1&playerapiid=#{yt_vid_id}&version=3"
    swfobject.embedSWF(url, yt_vid_id, "610", "400", "8", null, null, params, atts)



  yt_player_stat_change: (state) ->
    console.log 'yt player state change'
    console.log 'event'

  toggle_song_highlight: ->
    $(@el).toggleClass('highlight')
