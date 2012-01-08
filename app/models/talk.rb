class Talk < ActiveRecord::Base
  include Timeboxed

  belongs_to :user
  belongs_to :venue
  belongs_to :camp #denormalized from venue because talks start off w/out a venue when a camp is created

  validates_presence_of :user_id
  validates_presence_of :venue_id

  scope :after, lambda { |time| where("start_at >= :time", :time => time) }
  scope :before, lambda { |time| where("start_at <= :time", :time => time) }
  scope :for_day, lambda { |day| self.after(day.beginning_of_day).before(day.end_of_day).order(:start_at) }
  scope :in_progress, lambda { self.before(Time.now).where("end_at > :time", :time => Time.now) }

  def self.for_venue(venue)
    where(:venue_id => venue.id)
  end

  def day
    start_at.to_date
  end
  
  def duration
    end_at - start_at
  end
  
  def remaining
    remnants = end_at - Time.now
    remnants = [duration, remnants].min # To cap it at the talk's length
    [0, remnants].max # So that we don't end up with a negative time if it's in the past.
  end

end
