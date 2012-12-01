require 'csv'

desc 'csv loader'
task :load_csv => :environment do
  year = 2011
  file_name =  "#{year}_songs.csv"
  csv_file = File.expand_path(File.join('db', 'fixtures', file_name))

  puts "importing #{csv_file}"
  songs = 0
  CSV.foreach(csv_file, {headers: true, col_sep: "|"}) do |row|
    artist_name = row['artist']
    song_name = row['song']
    puts "#{artist_name}-#{song_name}"

    artist = Artist.find_by_name(artist_name)
    artist ||= Artist.create(name: artist_name)
    song = artist.songs.where(name:song_name, year: year).first
    unless song
      artist.songs.create(name:song_name, year: year)
      songs += 1
    end
  end
  Song.where(name:nil).delete_all
  Artist.where(name:nil).delete_all
  puts "done! - songs imported #{songs}"
end
