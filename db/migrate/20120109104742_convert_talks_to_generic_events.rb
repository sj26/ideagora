class Talk < ActiveRecord::Base; end

class ConvertTalksToGenericEvents < ActiveRecord::Migration
  
  def self.up
    add_column :talks, :type, :string
    Talk.all.map { |thing| thing.type = thing.class.to_s; thing.save! }
  end

  def self.down
    remove_column :talks, :type
  end
end