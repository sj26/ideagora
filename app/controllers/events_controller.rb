class EventsController < InheritedResources::Base
  before_filter :details

  def index
    @in_progress = @camp.events.in_progress
    @upcoming = @camp.events.after(Time.now)
    index!
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
