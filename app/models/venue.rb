class Venue < ActiveRecord::Base
  validates_presence_of :name
  belongs_to :camp
  has_many :talks
  
  def to_s
    name
  end
end
