class Status < ActiveRecord::Base
  belongs_to :project
  
  def to_s
    title
  end
end
