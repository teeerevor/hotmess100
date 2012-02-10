class CreateSongs < ActiveRecord::Migration
  def self.up
    create_table :songs do |t|
      t.string :name
      t.integer :artist_id
      t.text :desc
      t.integer :year
    end
  end

  def self.down
    drop_table :songs
  end
end
