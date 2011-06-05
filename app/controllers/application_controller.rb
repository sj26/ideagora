class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :requires_login, :organiser?
  

  private  
  def current_user  
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

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
  
end
