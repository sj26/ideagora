class AddCompletedDate < ActiveRecord::Migration
  def self.up
    add_column :projects, :status_changed_at, :datetime
  end

  def self.down
    remove_column :projects, :status_changed_at
  end
end