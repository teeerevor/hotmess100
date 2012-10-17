class window.Hotmess.Views.SongView extends Backbone.View
  tagName: 'li'
  className: 'song'

  events:
    'click .short_list_song'   : 'add_to_short_list'
    'click .short_list_to_pos' : 'add_to_short_list_at'
    'click .remove'            : 'remove_from_short_list'
    'click .song_details'      : 'toggle_song'
    'hover .song_header'          : 'toggle_song_highlight'

  initialize: ->
    @model.bind 'reset', @render

  render: ->
    $(@el).html(@template(@model.toJSON()))
    @

  template: (model)->
    Handlebars.registerHelper 'first_letter', (str)->
      str.charAt(0)
    Handlebars.registerHelper 'song_name_trim', (str)->
      if str.length > 37
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
    $(@el).toggleClass('expanded')
    yt_holder = @.$('.youtube_vid')
    if $(@el).hasClass('expanded')
      @load_youtube_vid(yt_holder, @model.attributes.youtube_url)
      yt_holder.fitVids()
    else
      yt_holder.empty()

  load_youtube_vid: (yt_container, yt_vid_id) ->
    yt_container.append("<div id='#{yt_vid_id}'></div>")
    params = { allowScriptAccess: "always" }
    atts = { id: yt_vid_id }
    url = "http://www.youtube.com/v/#{yt_vid_id}?enablejsapi=1&playerapiid=#{yt_vid_id}&version=3"
    swfobject.embedSWF(url, yt_vid_id, "610", "400", "8", null, null, params, atts)
    openSongs[yt_vid_id] = @



  yt_player_stat_change: (state) ->
    console.log 'yt player state change'
    console.log 'event'

  toggle_song_highlight: ->
    $(@el).toggleClass('highlight')
