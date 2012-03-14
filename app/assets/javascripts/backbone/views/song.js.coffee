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
    Handlebars.registerHelper 'first_letter', (str)->
      str.charAt(0)
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
      $(@el).find('.youtube_clip').html(@youtube_template(@model.toJSON()))
      $('.youtube_clip').fitVids()
    else
      $(@el).find('.youtube_clip').empty()
