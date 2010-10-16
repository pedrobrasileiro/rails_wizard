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
  
  helper_method :signed_in?, :current_user
end
