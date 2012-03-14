class CreateShortedSongs < ActiveRecord::Migration
  def self.up
    create_table :short_listed_songs do |t|
      t.integer :short_list_id
      t.integer :song_id
      t.integer :position
    end
  end

  def self.down
    drop_table :stort_listed_songs
  end
end
