class window.Hotmess.Views.SongView extends Backbone.View
  tagName: 'li'
  className: 'song'

  events:
    'click .short_list_song'   : 'add_to_short_list'
    'click .short_list_to_pos' : 'add_to_short_list_at'
    'click .remove'            : 'remove_from_short_list'

  initialize: ->
    @model.bind 'reset', @render

  add_to_short_list: ->
    window.shortList.add(@model)

  add_to_short_list_at: ->
    window.shortList.add(@model, {at: 0})

  remove_from_short_list: ->
    window.shortList.remove(@model)

  template: (model)->
    tp = Handlebars.compile($('#song-template').html())
    tp(model)

  render: ->
    $(@el).html(@template(@model.toJSON()))
    @

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
