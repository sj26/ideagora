class WelcomeController < ApplicationController
  def index
    @todays_talks_by_venue_id = Hash.new
    @venues = Camp.current.venues
    @venues.each do |v|
      @todays_talks_by_venue_id[v.id] = Camp.current.talks.for_day( params[:day].try(:to_date) || Time.now.to_date )
    end

    @latest_notice = Camp.current.notices.last
    @project = Project.random
  end
end
