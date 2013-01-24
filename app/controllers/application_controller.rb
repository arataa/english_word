class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user 

  private
  before_filter :check_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def check_user
    #return if controller_name == "sessions"
    #redirect_to "/login" if current_user.nil?
  end

end
