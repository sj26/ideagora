class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :thought
  
  validates :thought_id, :uniqueness => { :scope => :user_id, :message => "You couldn't possibly like this more than you already do!" }
end
