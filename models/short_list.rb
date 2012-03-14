class ShortList < ActiveRecord::Base
  has_many :short_listed_songs
  has_many :songs, :through => :short_listed_songs

  def short_list_songs(songs)
    new_song_list = songs.map{|song| song[:id].to_i}
    unless self.match(new_song_list)
      short_listed_songs.destroy_all
      add_songs_to_list(new_song_list)
    end
  end

  def match(new_list)
    current_list = short_listed_songs.map(&:song_id)
    current_list == new_list
  end

  def add_songs_to_list(songs)
    Song.find(songs)
    songs.each_with_index do |song_id, pos|
      short_listed_songs.create(song_id: song_id, position: pos)
    end
  end
end
