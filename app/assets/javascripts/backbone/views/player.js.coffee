class window.Hotmess.Views.PlayerView extends Backbone.View
  tagName: 'div'
  className: 'player'

  events:
    'click .play'       : 'play'
    'click .pause'      : 'pause'
    'click .next'       : 'next'
    'click .shuffle'    : 'shuffle'

  initialize: ->
    @model.bind 'reset', @render

  render: ->
    $(@el).html(@template(@model.toJSON()))
    @

  template: (model)->
    tp = Handlebars.compile($('#player-template').html())
    tp(model)

  play: ->
    #stuff
  pause: ->
    #stuff
  next: ->
    #stuff
  shuffle: ->
    #stuff
