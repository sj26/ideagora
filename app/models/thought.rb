class Thought < ActiveRecord::Base
  has_one :ancestor, :class_name => "Thought"
  belongs_to :user
end
