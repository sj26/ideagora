class OnlyAllowOneLikePerUser < ActiveRecord::Migration
  def self.up
    add_index :likes, [:user_id, :thought_id], :unique => true
  end

  def self.down
    remove_index :likes, :column => [:user_id, :thought_id]
  end
end