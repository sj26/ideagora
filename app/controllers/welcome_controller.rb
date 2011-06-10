class WelcomeController < ApplicationController
  def index
    @todays_talks_by_venue_id = Hash.new
    @venues = camp.venues
    @venues.each do |v|
      @todays_talks_by_venue_id[v.id] = camp.talks.for_day( params[:day].try(:to_date) || Time.now.to_date ).for_venue(v)
    end

    @latest_notice = camp.notices.last
    @projects = Project.limit(3)
  end
  
  private
  
  def camp
    Camp.current
  end
end
