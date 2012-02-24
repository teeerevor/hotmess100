class AddFieldsToSongs < ActiveRecord::Migration
  def self.up
    add_column :songs, :youtube_url, :string
    add_column :songs, :soundcloud_url, :string
  end

  def self.down
    remove_column :songs, :youtube_url
    remove_column :songs, :soundcloud_url
  end
end
