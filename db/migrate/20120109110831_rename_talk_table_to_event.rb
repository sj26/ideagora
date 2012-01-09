class RenameTalkTableToEvent < ActiveRecord::Migration
  def self.up
    rename_table :talks, :events
  end

  def self.down
    rename_table :events, :talks
  end
end
