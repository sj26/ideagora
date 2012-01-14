class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :requires_login, :organiser?
  before_filter :set_time_zone
  
  private  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  
  def current_camp
    @current_camp = Camp.current
  end
  helper_method :current_camp

  def organiser?
    current_user && current_user.organiser?
  end

  def requires_organiser
    unauthorised! unless organiser?
  end
  
  def requires_login
    unauthorised! unless current_user
  end
  
  def unauthorised!
    redirect_to(root_path, :alert => "Unauthorised!")
  end

  def set_time_zone
    Time.zone = current_camp.time_zone
  end

  def load_discussion_for_path
    @discussion = Discussion.for_camp_and_path(current_camp, request.path)
  end
end
