class Thought < ActiveRecord::Base
  has_one :ancestor, :class_name => "Thought"
  has_many :likes
  belongs_to :user
  has_many :fans, :through => :likes
end
