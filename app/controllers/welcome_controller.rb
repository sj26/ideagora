class WelcomeController < ApplicationController
  def index
    @talks = camp.upcoming_talks.limit(3)

    @events = camp.events.after(Time.now).limit(3)
    @events = @events.where(:type => nil) # FIXME: Subtype the camp catering events

    @latest_notice = camp.notices.last
    @project = Project.order('random()').first
  end
  
  private
  
  def camp
    Camp.current
  end
end
