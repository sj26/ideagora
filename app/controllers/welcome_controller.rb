class WelcomeController < ApplicationController
  def index
    @talks = current_camp.upcoming_talks.limit(3)

    @events = current_camp.events.after(Time.current).limit(3)
    @events = @events.where(:type => nil)

    @latest_notice = current_camp.notices.last
    @project = Project.random
  end  
end
