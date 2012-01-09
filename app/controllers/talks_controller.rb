class TalksController < InheritedResources::Base
  before_filter :details
  before_filter :requires_login, :except => [:index, :show]

  def index
    @in_progress = @camp.talks.in_progress
    @upcoming = @camp.upcoming_talks
    index!
  end

  def calendar
    @talks_by_time_and_venue_for_day = @camp.talks_by_time_and_venue_for_day(@day)
    index!
  end

  def new
    @users = @camp.users.order(:first_name)
    @start_at = Time.parse(params[:start_at])
    @end_at = @start_at + 1.hour
    @venue = Venue.find(params[:venue_id])
    @talk = Talk.new(:start_at => @start_at, :end_at => @end_at, :venue => @venue, :user => current_user)
    new!
  end

  def edit
    @users = @camp.users.order(:first_name)
    edit!
  end

  def create
    @talk = Talk.new(params[:talk])
    @talk.user = current_user
    create!
  end

private
  def current_camp
    @camp = Camp.current
  end

  def details
    current_camp
    @day = best_day
    @venues = @camp.venues
    @talk_days = @camp.talk_days
  end

  def best_day
    date = params[:day] && Date.parse(params[:day])
    date ||= Date.today if @camp.talk_days.include?(Date.today)
    date ||= @camp.talk_days.first
    date
  end
end
