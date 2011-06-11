class Project < ActiveRecord::Base
  validates_presence_of :name, :owner
  
  belongs_to :owner, :class_name => "User", :foreign_key => :user_id
  has_one :status
 
  before_save :create_status
 
  def needs_help?
    !!help
  end
  
  def self.random
    if count > 0
      offset = rand(count)
      first(:offset => offset)
    end
  end
  
  
  
  def active?
    status.kind_of?(Active)
  end
  
  def done?
    status.kind_of? Done
  end
  alias :complete? :done?
  alias :completed? :done?
  
  def canned?
    status.kind_of? Canned
  end

private
  def create_status
    self.status ||= Active.new
  end
end
