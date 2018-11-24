class Thought < ActiveRecord::Base
  has_one :ancestor, :class_name => "Thought"
  belongs_to :user
  has_many :likes
  has_many :fans, :through => :likes, :source => :user
  
  validates_presence_of :description, :message => "Surely you have something on your mind?"
  
  scope :upvoted, lambda { |count| where('likes_count >= :count', :count => count || 1) }
  
  default_scope { order('likes_count desc') }
  
  def liked_by?(user)
    fans.exists? user
  end
  
  before_validation do |thought|
    thought.description.try(:strip!)
  end
end
