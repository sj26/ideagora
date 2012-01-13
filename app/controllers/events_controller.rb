class EventsController < InheritedResources::Base
  before_filter :details

  def index
    @in_progress = @camp.events.in_progress
    @upcoming = @camp.events.after(Time.now)
    index!
  end

  def new
    @event = Event.new
    @event.user = current_user if current_user
    @event.start_at = 1.hour.from_now
    @event.end_at = @event.start_at + 1.hour
    new!
  end

private
  def current_camp
    @camp = Camp.current
  end

  def details
    current_camp
    @day = best_day
    @venues = @camp.venues
  end

  def best_day
    date = params[:day] && Date.parse(params[:day])
    date ||= Date.today if @camp.talk_days.include?(Date.today)
    date ||= @camp.talk_days.first
    date
  end
end
