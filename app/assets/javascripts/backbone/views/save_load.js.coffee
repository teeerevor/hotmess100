delay = (->
  timer = 0
  (callback, ms) ->
    clearTimeout timer
    timer = setTimeout(callback, ms)
)()

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
    sl = @
    $('#header').addClass('open')
    $('#email').on 'keyup', ->
      delay (->
        sl.showInlineValidation()
      ), 1000

  close: ->
    $('#email').off('keyup')
    $('#header').removeClass('open')

  form: ->
    @.$('form')

  email: ->
    @.$('#email').val()


  load: (e) ->
    e.preventDefault()
    @ifEmailIsValid( ->
      @setEmailDisplay()
      window.shortList.loadList @email()
      @close())

  save: (e) ->
    e.preventDefault()
    @ifEmailIsValid( ->
      @setEmailDisplay()
      window.shortList.saveList @email()
      @close())

  send: (e)->
    e.preventDefault()
    @ifEmailIsValid( ->
      @setEmailDisplay()
      @close())

  setEmailDisplay: ->
    @.$('.current_email').text(@email())
    @.$('.current_email').show()

  validateEmail: (email) ->
    emailRegex = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return emailRegex.test(email)

  showInlineValidation: ->
    if @email().length > 0
      if @validateEmail @email()
        @showValid()
      else
        @showInvalid()
    else
      @form().removeClass('valid invalid')

  showValid: ->
    unless @form().is('.valid')
      @form().removeClass('invalid')
      @form().addClass('valid')

  showInvalid: ->
    unless @form().is('.invalid')
      @form().removeClass('valid')
      @form().addClass('invalid')

  checkEmail: (callback) ->
    if @validateEmail @email()
      callback()
    else
      @showInvalidEmailMsg()

  showInvalidEmailMsg: ->
    @showErrorMessage('That dosen\'t look right, please check the email address you entered.')

  showErrorMessage: (msg) ->
    alert(msg)

window.Hotmess.Views.SaveLoadView = SaveLoadView
