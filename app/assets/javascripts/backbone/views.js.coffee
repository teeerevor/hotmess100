class window.Hotmess.Views.SongView extends Backbone.View
  tagName: 'li'
  className: 'song'

  events:
    'click .short_list_song'   : 'add_to_short_list'
    'click .short_list_to_pos' : 'add_to_short_list_at'
    'click .remove'            : 'remove_from_short_list'
    'click .song_details'      : 'expand_song'

  initialize: ->
    @model.bind 'reset', @render

  render: ->
    $(@el).html(@template(@model.toJSON()))
    @

  template: (model)->
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

  expand_song: ->
    $(@el).toggleClass('expanded')
    if $(@el).hasClass('expanded')
      $(@el).find('#youtube_clip').html(@youtube_template(@model.toJSON()))
    else
      $(@el).find('#youtube_clip').empty()


class window.Hotmess.Views.SongsListView extends Backbone.View
  tagName:    'ol'
  className:  'song_list'

  initialize: ->
    @collection.bind 'reset', @render, @

  render: ->
    $(@el).empty()
    for song in @collection.models
      songView = new Hotmess.Views.SongView({model: song})
      $(@el).append songView.render().el
    @


class window.Hotmess.Views.ShortListView extends Hotmess.Views.SongsListView
  className:  'short_list'

  initialize: ->
    @collection.bind 'add', @render, @
    @collection.bind 'reset', @render, @
    @collection.bind 'remove', @render, @
