class SessionsController < ApplicationController
  def create
    self.current_user = User.from_hash(request.env['omniauth.auth'])
    redirect_to '/'
  end
  
  def destroy
    session.delete(:user_id)
    flash[:notice] = 'You are now signed out.'
    redirect_to '/'
  end
end
