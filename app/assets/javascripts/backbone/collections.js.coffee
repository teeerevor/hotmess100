class window.Hotmess.Collections.Songs extends Backbone.Collection
  model: Hotmess.Models.Song

class window.Hotmess.Collections.ShortList extends Hotmess.Collections.Songs
  url: '/short_lists/'

  loadList: (email) ->
    @url = "/short_lists/#{email}"
    @fetch()

  saveList: (email) ->
    @url = "/short_lists/#{email}"
    $.post(@url, {songs: @.pluck('id')})
