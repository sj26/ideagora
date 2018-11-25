class Project < ActiveRecord::Base
  validates_presence_of :name, :owner
  
  belongs_to :owner, class_name: "User", foreign_key: :user_id

  state_machine :status, initial: :active do
    state :active
    state :done
    state :fail

    event :complete do
      transition :active => :done
    end
    
    event :cancel do
      transition :active => :fail
    end
    
    event :restart do
      transition all => :active
    end
  end

  def self.random
    order("random()").first
  end
end
