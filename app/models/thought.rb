class Thought < ActiveRecord::Base
  has_one :ancestor, :class_name => "Thought"
end
