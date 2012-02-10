require 'csv'

namespace :song_import do
  desc 'imports hottest 100 songs'
  task :import => :environment do
    csv_file = File.expand_path(File.join('db', 'fixtures', '2011_artists.csv'))
    year = 2011

    unless File.exists? csv_file
      puts "File does not exist"
      puts "looking for #{csv_file}"
      return
    end

    puts "importing #{csv_file}"
    songs = 0
    CSV.foreach(csv_file, {headers: true, col_sep: "|"}) do |row|
      artist_name = row['artist']
      song_name = row['song']
      puts "#{artist_name}-#{song_name}"

      artist = Artist.find_by_name(artist_name)
      artist ||= Artist.create(name: artist_name)
      song = artist.songs.where(name:song_name, year: year).first
      artist.songs.create(name:song_name, year: year) unless song
      songs += 1
    end
    puts "Done! - Songs imported #{songs}"
  end
end
