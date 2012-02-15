class window.Hotmess.Views.SongView extends Backbone.View
  tagName: 'li'

  initalize: ->
    @model.bind 'reset', @render

  render: ->
    template = Handlebars.compile(Hotmess.Templates.Song)
    $(@el).html(template(@model.toJSON()))
    @

class window.Hotmess.Views.SongsListView extends Backbone.View
  tagName: 'section'
  id:  'song_list'

  render: ->
    $(@el).find('ul').empty()
    for song in @collection.models
      songView = new Hotmess.Views.SongView({model: song})
      $(@el).find('ul').append songView.render().el
    @


class window.Hotmess.Views.ShortListView extends Hotmess.Views.SongListView
  id:  'short_list'

