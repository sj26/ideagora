module Timeboxed
  module InstanceMethods

    def duration
      end_at - start_at
    end
  
    def remaining
      remnants = end_at - Time.now
      remnants = [duration, remnants].min # To cap it at the talk's length
      [0, remnants].max # So that we don't end up with a negative time if it's in the past.
    end

    private

    def start_at_is_less_than_end_at
      if start_at.blank? || end_at.blank? || start_at >= end_at
        errors.add :start_at, "The start time must be before the end time" 
      end
    end

  end

  def self.included(base)
    base.send :include, InstanceMethods
    base.validates_presence_of :start_at, :end_at
    base.validate :start_at_is_less_than_end_at
  end


end