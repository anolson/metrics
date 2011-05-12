class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :verify_user_authentication
  
  def verify_user_authentication
    unless has_authenticated?
      session[:return_to] = request.fullpath
      redirect_to login_path
    end
  end
  
  def has_authenticated?
    session[:user] != nil
  end
  helper_method :has_authenticated?
  
  def setup_session(user)
    session[:user] = user.id
    redirect_to_intended_path(user)
  end
  
  def redirect_to_intended_path(user)
    session[:return_to] ? redirect_to(session[:return_to]) : redirect_to(users_rides_path(user.username))
    session[:return_to] = nil
  end

end
