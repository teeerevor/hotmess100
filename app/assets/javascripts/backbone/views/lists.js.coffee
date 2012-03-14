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
