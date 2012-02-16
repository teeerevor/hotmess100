class window.Hotmess.Views.SongView extends Backbone.View
  tagName: 'li'

  initalize: ->
    @model.bind 'reset', @render

  template: (model)->
    tp = Handlebars.compile(Hotmess.Templates.Song)
    return tp(model)

  render: ->
    $(@el).html(@template(@model.toJSON()))
    @

class window.Hotmess.Views.SongsListView extends Backbone.View
  tagName:    'ol'
  className:  'song_list'

  render: ->
    $(@el).empty()
    for song in @collection.models
      songView = new Hotmess.Views.SongView({model: song})
      $(@el).append songView.render().el
    @


class window.Hotmess.Views.ShortListView extends Hotmess.Views.SongsListView
  className:  'short_list'
