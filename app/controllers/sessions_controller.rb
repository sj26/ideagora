class SessionsController < ApplicationController
  def new
    if session[:user_id]
      redirect_to root_url, :notice => "Already logged in!"
    end
  end
  
  def create
    user = User.authenticate(params[:details])
    if user
      session[:user_id] = user.id
      redirect_to root_url, :notice => 'Logged in!'
    else
      flash.now.alert = 'Cannot log you in.'
      render 'new'
    end
  end
  
  def destroy
    unless session[:user_id]
      redirect_to root_url, :notice => "Not logged in!"
    else
      session.clear
      redirect_to root_url, :notice => "Logged out!"
    end
  end
end
