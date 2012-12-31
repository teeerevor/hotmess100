class AddShortListCreatedAt < ActiveRecord::Migration
  def self.up
    add_column :short_lists, :created_at, :datetime
  end

  def self.down
    remove_column :short_lists, :created_at
  end
end
