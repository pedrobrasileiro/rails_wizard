class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  
  protected
  
  def signed_in?
    !!current_user
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id])
  end
  
  def current_user=(user)
    session[:user_id] = user.id
    @current_user = user    
  end
  
  helper_method :signed_in?, :current_user
end
