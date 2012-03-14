class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :short_listed_songs
  has_many :short_lists, :through => :short_listed_songs

  def youtube_search_string
    "#{self.name} #{self.artist.the_name_fix}".gsub(/[^([a-z]|\s)]/i, '').strip.gsub(/\s+/, '+')
  end
end
