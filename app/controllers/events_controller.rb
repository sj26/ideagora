class EventsController < AuthenticatedController
  before_action :details

  def index
    @in_progress = current_camp.events.in_progress
    the_rest = current_camp.events.after(Time.now)
    @upcoming = the_rest.group_by { |a| (a.start_at + Time.zone.utc_offset + 1.hour).to_i / 6.hours }
    @upcoming = Hash[@upcoming.map { |key, val| [Time.zone.at(key * 6.hours - Time.zone.utc_offset - 1.hour), val] }]
    index!
  end
  
  def new
    @event = Event.new
    @event.user = current_user if current_user
    @event.start_at = 5.minutes.from_now
    @event.end_at = @event.start_at + 1.hour
    @thoughts = Thought.upvoted(1)
    new!
  end

  private

  def end_of_association_chain
    super.where(camp_id: current_camp.id)
  end

  def event_params
    params.require(:event).permit(:name, :description, :start_at, :end_at, :user_id, :venue_id)
  end

  def details
    current_camp
    @day = best_day
    @venues = current_camp.venues
  end

  def best_day
    date = params[:day] && Date.parse(params[:day])
    date ||= Date.today if current_camp.talk_days.include?(Date.today)
    date ||= current_camp.talk_days.first
    date
  end
end
