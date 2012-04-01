#class CoverManager ->
#window.coverManager = new CoverManager()

window.get_song = ->
    songs = _.shuffle(window.songsList.models)
    songs[0]

window.get_cover_img = ->
    covers = _.shuffle($('#bg img'))
    $(covers[0])

window.cycle_albums = ->
  song = @get_song()
  song = @get_song() until _.indexOf(cover_urls, song.get('album_img_url')) == -1
  url = song.get('album_img_url')
  console.log url
  @get_cover_img().attr('src', url )

$ ->
  window.cover_urls = []
  cover_urls.push $(cover).attr('src') for cover in $('#bg img')
  #setTimeout( -> cycle_albums(), 30 * 100 )
