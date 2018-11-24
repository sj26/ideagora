class Project < ActiveRecord::Base
  validates_presence_of :name, :owner
  
  belongs_to :owner, :class_name => "User", :foreign_key => :user_id

  state_machine :status, :initial => :active do
    before_transition nil => any do
      status ||= :active # A weird but interesting way to guard against an unset status
    end
    
    event :complete do
      transition :active => :done
    end
    
    event :cancel do
      transition :active => :fail
    end
    
    event :restart do
      transition all => :active
    end
    
    state :active, :value => "Active"
    state :done, :value => "DONE!"
    state :fail, :value => "Canned"
  end
  
  def self.random
    if count > 0
      offset(rand(count)).first
    end
  end
end
