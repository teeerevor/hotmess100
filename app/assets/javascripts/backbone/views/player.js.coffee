READY = -1
ENDED = 0
PLAYING = 1
STOPPED = 2
BUFFERING = 3

class window.Hotmess.Views.PlayerView extends Backbone.View
  tagName: 'div'
  className: 'player'

  events:
    'click .play'       : 'play'
    'click .pause'      : 'pause'
    'click .next'       : 'next'
    'click .shuffle'    : 'shuffle'
    'click .continuous' : 'continuous'

  initialize: ->
    @open_songs = {}
    @yt_players = {}
    @current_song_id = ''
    @player_mode = 'single'

  render: ->
    $(@el).html @template({})
    @

  template: (model) ->
    tp = Handlebars.compile($('#hottest-player-template').html())
    tp(model)

  open_song: (id, song) ->
    @open_songs[id] = song
    @current_song_id = id if @current_song_id == ''

  close_song: (id, song) ->
    @open_songs.delete[id]
    @yt_players.delete[id]

  yt_state_change: (player_id, player, state) ->
    console.log "yt_state_change #{state}"
    @yt_players[player_id] = player
    switch state
      when READY
        if @play_on_ready
          @play()
          @play_on_ready = false
      when ENDED then @pick_next_song()
      when PLAYING
        @pause() unless player_id == @current_song_id
        @show_play()
        @set_current_song(player_id)
      when STOPPED then @show_pause()
      when BUFFERING then @show_pause()

  set_current_song: (id) ->
    console.log "current_song #{id}"
    @current_song_id = id

  current_song: ->
    console.log 'current_song'
    @open_songs[@current_song_id]

  current_player: ->
    console.log 'current_player'
    @yt_players[@current_song_id]

  play: ->
    console.log 'play'
    if @current_player()
      @current_player().playVideo()

  show_play: ->
    console.log 'show_play'

  pause: ->
    console.log 'pause'
    if @current_player()
      @current_player().stopVideo()

  show_pause: ->
    console.log 'show_pause'

  pick_next_song: ->
    switch @player_mode
      when 'continuous'
        @next()
      #when 'shuffle'
        #stoa
      #when 'repeat'
        #stoeau

  next: ->
    console.log 'next'
    next_song = songsList.get_next_song(@current_song().model)
    @pause()
    @current_song().close()
    next_song.trigger 'open'
    @set_current_song(next_song.get('youtube_url'))
    @play_when_ready()

  play_when_ready: ->
    @play_on_ready = true

  continuous: ->
    console.log 'continuous'
    @player_mode = 'continuous'

  shuffle: ->
    #stuff
