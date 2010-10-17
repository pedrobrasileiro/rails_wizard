class UsersController < ApplicationController
  def show
    @page_title = user.name
  end
  
  protected
  
  def user
    @user ||= User.find_by_id(params[:id])
  end
  helper_method :user
end
