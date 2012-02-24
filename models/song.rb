class Song < ActiveRecord::Base
  belongs_to :artist

  def youtube_search_string
    "#{self.name} #{self.artist.the_name_fix}".gsub(/[^([a-z]|\s)]/i, '').strip.gsub(/\s+/, '+')
  end
end
