class TalksController < AuthenticatedController
  before_filter :details

  def index
    @in_progress = current_camp.talks.in_progress
    @upcoming = current_camp.upcoming_talks
    @upcoming = @upcoming.group_by { |a| (a.start_at + Time.zone.utc_offset + 1.hour).to_i / 6.hours }
    @upcoming = Hash[@upcoming.map { |key, val| [Time.zone.at(key * 6.hours - Time.zone.utc_offset - 1.hour), val] }]
    index!
  end

  def calendar
    @talks_by_time_and_venue_for_day = current_camp.talks_by_time_and_venue_for_day(@day)
    index!
  end

  def new
    @users = current_camp.users.order(:first_name)
    @start_at = Time.parse(params[:start_at])
    @end_at = @start_at + 1.hour
    @venue = Venue.find(params[:venue_id])
    @talk = Talk.new(:start_at => @start_at, :end_at => @end_at, :venue => @venue, :user => current_user)
    new!
  end

  def edit
    @users = current_camp.users.order(:first_name)
    edit!
  end

private
  def begin_of_association_chain
    current_camp
  end

  def details
    @day = best_day
    @venues = current_camp.venues
    @talk_days = current_camp.talk_days
  end

  def best_day
    date = params[:day] && Date.parse(params[:day])
    date ||= Date.today if current_camp.talk_days.include?(Date.today)
    date ||= current_camp.talk_days.first
    date
  end
end
