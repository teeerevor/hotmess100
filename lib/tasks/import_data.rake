require 'csv'
require 'uri'
require 'nokogiri'
require 'open-uri'
require 'googleajax'

namespace :song_import do
  desc 'imports hottest 100 songs'
  task :import => :environment do
    csv_file = file.expand_path(file.join('db', 'fixtures', '2011_artists.csv'))
    year = 2011

    unless file.exists? csv_file
      puts "file does not exist"
      puts "looking for #{csv_file}"
      return
    end

    puts "importing #{csv_file}"
    songs = 0
    csv.foreach(csv_file, {headers: true, col_sep: "|"}) do |row|
      artist_name = row['artist']
      song_name = row['song']
      puts "#{artist_name}-#{song_name}"

      artist = artist.find_by_name(artist_name)
      artist ||= artist.create(name: artist_name)
      song = artist.songs.where(name:song_name, year: year).first
      artist.songs.create(name:song_name, year: year) unless song
      songs += 1
    end
    puts "done! - songs imported #{songs}"
  end
end

namespace :lastfm_import do
  desc 'imports hottest 100 artist data from lastfm'
  task :run => :environment do
    LASTFM_API_KEY = '199ccc69045a31eb478889eb98f66cc5'
    #Song.all(:include => :artist, :order => 'songs.name').each do |song|
    Artist.all.each do |artist|
      #artist = song.artist
      puts "artist = #{artist.the_name_fix}"
      url = "http://ws.audioscrobbler.com/2.0/?method=artist.getinfo&artist=#{URI.escape(artist.the_name_fix)}&api_key=#{LASTFM_API_KEY}"
      begin
        doc = Nokogiri::XML(open(url))
        artist.image = doc.css('image[@size="extralarge"]').first.text
        desc = doc.css('bio summary').text
        if desc =~ /ID3 tags/i
          puts '* fail *'
          puts url
          desc = 'fail'
        end
        #remove the htmls
        artist.desc = desc.gsub(/<(?:"[^"]*"['"]*|'[^']*'['"]*|[^'">])+>/, '')
        artist.save
      rescue
        puts "********** error ************"
        puts url
      end
    end
  end
end


namespace :youtube_url_fetch do
  desc 'grabs youtube urls'
  task :run => :environment do
    Song.all.each do |song|
      puts "artist = #{song.artist.name}|#{song.name}"
      url = "http://www.youtube.com/results?search_query=#{song.youtube_search_string}+-live"
      begin
        doc = Nokogiri::HTML(open(url))
        url = doc.css('#search-results').first.css('a').first.attr('href')
        song.youtube_url = url.gsub(/watch\?v=/i ,'embed/')
        song.youtube_url = url.gsub!(/watch\?v=/i ,'embed/')
        puts url
        song.save
      rescue
        puts "********** error ************"  
        puts "song = #{song.id}"
        puts url
      end
    end
  end
end

namespace :album_art_url_fetch do
  desc 'grabs album artwork from goog image search'
  task :run => :environment do
    GoogleAjax.referer = "hotmess100.io"
    Song.all.each do |song|
      puts "artist/song = #{song.artist.name}|#{song.name}"
      puts "search_string = #{song.youtube_search_string}"
      begin
        GoogleAjax::Search.images(song.youtube_search_string+'+cover')[:results].each do |img|
          if img[:width] == img[:height]
            song.album_img_url = img[:url]
            song.save
            puts img[:url]
            break
          end
        end
      rescue
        puts "********** error ************"  
        puts "song = #{song.id}"
      end
    end
  end
end
