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
    'hover .close_form_button' : 'hover_close_button'
    'click .close_form_button' : 'close'

  render: ->
    $(@el).html @template({})
    @

  template: (model) ->
    tp = Handlebars.compile $('#saveload-template').html()
    tp(model)

  open: ->
    self = @
    $('#header').addClass('open')
    $('#email').on 'keyup', ->
      delay (->
        self.form().removeClass('valid invalid blank')
        self.showInlineValidation()
      ), 1000

  close: ->
    $('#email').off('keyup')
    $('#header').removeClass('open')

  hover_close_button: ->
    $('.close_form_button').toggleClass('highlight')

  form: ->
    @.$('form')

  email: ->
    @.$('#email').val()


  load: (e) ->
    e.preventDefault()
    self = @
    @doIfEmailIsValid( ->
      self.setEmailDisplay()
      window.shortList.loadList self.email()
      self.close()
    , self)

  save: (e) ->
    e.preventDefault()
    self = @
    @doIfEmailIsValid( ->
      self.setEmailDisplay()
      window.shortList.saveList self.email()
      self.close()
    , self)

  send: (e)->
    e.preventDefault()
    self = @
    @doIfEmailIsValid( ->
      self.setEmailDisplay()
      self.close()
    , self)

  setEmailDisplay: ->
    @.$('.current_email').text(@email()).show()
    @.$('.list_label').hide()

  validateEmail: (email) ->
    emailRegex = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return emailRegex.test(email)

  showInlineValidation: ->
    if @email().length > 0
      if @validateEmail @email()
        @form().addClass('valid')
      else
        @form().addClass('invalid')
    else
      @form().addClass('blank')

  doIfEmailIsValid: (callback, self) ->
    if self.validateEmail self.email()
      callback()
    else
      self.showInvalidEmailMsg()

  showInvalidEmailMsg: ->
    @showErrorMessage('That dosen\'t look right, please check the email address you entered.')

  showErrorMessage: (msg) ->
    alert(msg)

window.Hotmess.Views.SaveLoadView = SaveLoadView
