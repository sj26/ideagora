class Discussion < ActiveRecord::Base
  belongs_to :camp

  def self.for_camp_and_path(camp, path)
    self.where(:camp_id => camp.id, :path => path).first
  end
end
