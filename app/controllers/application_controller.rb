class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :verify_user_authentication
  before_filter :current_user
  
  private 
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

    def remember_user
      session[:user] = cookies.signed[:remember_me] if cookies.signed[:remember_me]
    end
  
    def setup_session(user)
      session[:user] = user.id
      redirect_to_intended_path(user)
    end
  
    def redirect_to_intended_path(user)
      session[:return_to] ? redirect_to(session[:return_to]) : redirect_to(users_rides_path(user.username))
      session[:return_to] = nil
    end
  
    def current_user
      remember_user
      @current_user ||= User.find(session[:user]) if has_authenticated?
    end

end
