class CreateShortlist < ActiveRecord::Migration
  def self.up
    create_table :short_lists do |t|
      t.string :email
      t.integer :year
    end
  end

  def self.down
    drop_table :short_lists
  end
end
