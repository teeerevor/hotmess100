class SaveLoadView extends Backbone.View
  id: 'save_load'

  events:
    'click .email_display'  : 'open'
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

  load: (e) ->
    e.preventDefault()
    @setEmailDisplay()
    window.shortList.loadList @email()
    @close()

  save: (e) ->
    e.preventDefault()
    @setEmailDisplay()
    window.shortList.saveList @email()
    @close()

  send: (e)->
    e.preventDefault()
    @setEmailDisplay()
    @close()

  setEmailDisplay: ->
    @.$('.current_email').text(@email())
    @.$('.current_email').show()


window.Hotmess.Views.SaveLoadView = SaveLoadView
