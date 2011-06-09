class CreateDiscussions < ActiveRecord::Migration
  def self.up
    create_table :discussions do |t|
      t.string :path
      t.integer :camp_id
      t.string :title
      t.text :text

      t.timestamps
    end
  end

  def self.down
    drop_table :discussions
  end
end
