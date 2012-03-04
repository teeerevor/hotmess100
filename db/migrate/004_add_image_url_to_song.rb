class AddImageUrlToSong < ActiveRecord::Migration
  def self.up
    add_column :songs, :album_img_url, :string
  end

  def self.down
    remove_column :songs, :album_img_url
  end
end
