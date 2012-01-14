class Thought < ActiveRecord::Base
  has_one :ancestor, :class_name => "Thought"
  belongs_to :user
  has_many :likes
  has_many :fans, :through => :likes, :source => :user
  
  def liked_by?(user)
    fans.exists? user
  end
end
