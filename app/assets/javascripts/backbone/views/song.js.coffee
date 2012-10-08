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
    yt_holder = @.$('.youtube_clip')
    if $(@el).hasClass('expanded')
      #yt_holder.html(@youtube_template(@model.toJSON()))
      @fire_up_song(yt_holder)
      yt_holder.fitVids()
    else
      yt_holder.empty()

  fire_up_song: (cont) ->
    cont.html("<div id='myid'></div>")
    params = { allowScriptAccess: "always" }
    atts = { id: "myid" }
    swfobject.embedSWF("http://www.youtube.com/v/-9Iv4v52ras?enablejsapi=1&playerapiid=ytplayer&version=3",
                       "myid", "610", "400", "8", null, null, params, atts)

  toggle_song_highlight: ->
    $(@el).toggleClass('highlight')
