window.App = {
  sections: ['intro', 'compatibility', 'wild']

  progressBar: null

  init: ->
    self = @

    @progressBar = $("#progress_bar")
    @progressBar.removeClass("transition").addClass("error").addClass("transition")
    $(".ui-progress .ui-label", @progressBar).hide()
    $(".ui-progress", @progressBar).css "width", "7%"
    $(".ui-progress", @progressBar).animateProgress 35, ->
      self.load_backbone()
      $("#progress_bar").removeClass("error").addClass "warning"
      $("#progress_bar .ui-progress").animateProgress 60, ->
        songsList.fetch({dataType: 'json'})
        setTimeout (->
          $("#progress_bar").removeClass "warning"
          $("#progress_bar .ui-progress").animateProgress 100, ->
              $('#app').removeClass('hidden')
              $('.list_index').removeClass('hidden')
              $('#progress_bar').remove()
              #self.setupWaypoints()
        ), 1000

  load_backbone: ->
    window.songsList = new Hotmess.Collections.Songs({localStorage: new Store("songList2011")})
    window.songListView = new Hotmess.Views.SongsListView({collection: songsList})
    window.shortList = new Hotmess.Collections.ShortList({localStorage: new Store("shortList2011")})
    window.shortListView = new Hotmess.Views.ShortListView({collection: shortList})
    window.saveLoadView = new Hotmess.Views.SaveLoadView({})
    window.hottestPlayer = new Hotmess.Views.PlayerView({})

    $('#song_list').append(songListView.render().el)
    $('#short_list').append(shortListView.render().el)
    $('#header').append(hottestPlayer.render().el)
    $('#header').append(saveLoadView.render().el)


  fadeIn: (section) ->
    $("section.#{section}").fadeIn 'slow'

  fadeInNextSection: ->
    @fadeIn(@sections.shift()) if @sections.length > 0

  setupWaypoints: ->
    $.waypoints.settings.scrollThrottle = 30
    $("#short_list").waypoint (event, direction) ->
      $(this).toggleClass "sticky", direction is "down"
      event.stopPropagation()
}

$ ->
  App.init()
