class window.Hotmess.Collections.Songs extends Backbone.Collection
  url: '/songs/'
  model: Hotmess.Models.Song

  get_next_song: (song) ->
    song_index = _.indexOf( @.models, song)
    @.models[song_index + 1]

class window.Hotmess.Collections.ShortList extends Hotmess.Collections.Songs
  url: '/short_lists/'

  loadList: (email) ->
    @url = "/short_lists/#{email}"
    @fetch()

  saveList: (email) ->
    @url = "/short_lists/#{email}"
    $.post(@url, {songs: @.pluck('id')})
