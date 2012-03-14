class SaveLoadView extends Backbone.View
  id: 'save_load'

  events:
    'click span'  : 'open'
    'click .load' : 'load'
    'click .save' : 'save'
    'click .send' : 'send'

  render: ->
    $(@el).html @template({})
    @

  template: (model) ->
    tp = Handlebars.compile $('#saveload-template').html()
    tp(model)

  open: ->
    $('#header').addClass('open')

  close: ->
    $('#header').removeClass('open')

  email: ->
    @.$('#email').val()

  load: ->
    window.shortList.loadList @email()
    @close()

  save: ->
    window.shortList.saveList @email()
    @close()

  send: ->
    @close()


window.Hotmess.Views.SaveLoadView = SaveLoadView
