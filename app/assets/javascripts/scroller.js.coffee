window.Scroller = {
  watchScroll: ->
    $(window).on 'scroll', ->
      if @scrollTimer
        clearTimeout(scrollTimer)

      @scrollTimer = setTimeout( Scroller.screenScrolled, 100)

  screenScrolled: ->
    @lastScrollPos ||= 0
    @currentScrollPos = $(window).scrollTop()
    if @currentScrollPos > @lastScrollPos
      $('body').removeClass('scrolled_up')
      $('body').addClass('scrolled_down')
    else
      $('body').addClass('scrolled_up')
      $('body').removeClass('scrolled_down')

    $('body').removeClass('top')

    console.log @lastScrollPos
    console.log @currentScrollPos
    @lastScrollPos = @currentScrollPos
}

$ ->
  Scroller.watchScroll()
