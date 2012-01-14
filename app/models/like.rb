class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :thought, :counter_cache => true
  
  validates :thought_id, :uniqueness => { :scope => :user_id, :message => "You couldn't possibly like this more than you already do!" }
  
  scope :for_user, lambda { |user| self.where(:user_id => user.id) }
end
