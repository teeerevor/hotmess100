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
        ), 1000

  load_backbone: ->
    window.songsList = new Hotmess.Collections.Songs()
    window.songListView = new Hotmess.Views.SongsListView({collection: songsList})
    window.shortList = new Hotmess.Collections.ShortList()
    window.shortListView = new Hotmess.Views.ShortListView({collection: shortList})
    window.saveLoadView = new Hotmess.Views.SaveLoadView({})

    $('#song_list').append(songListView.render().el)
    $('#short_list').append(shortListView.render().el)
    $('#header').append(saveLoadView.render().el)


  fadeIn: (section) ->
    $("section.#{section}").fadeIn 'slow'

  fadeInNextSection: ->
    @fadeIn(@sections.shift()) if @sections.length > 0
}

$ ->
  App.init()