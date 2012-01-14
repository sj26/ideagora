class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :thought
end
