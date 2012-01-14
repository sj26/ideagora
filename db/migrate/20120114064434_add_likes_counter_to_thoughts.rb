class AddLikesCounterToThoughts < ActiveRecord::Migration
  def self.up
    add_column :thoughts, :likes_count, :integer
  end

  def self.down
    remove_column :thoughts, :likes_count
  end
end