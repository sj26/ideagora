class Project < ActiveRecord::Base
  validates_presence_of :name, :owner
  
  belongs_to :owner, :class_name => "User", :foreign_key => :user_id
  
  def needs_help?
    !!help
  end
  
  def self.random
    if count > 0
      offset = rand(count)
      first(:offset => offset)
    end
  end
  
end
