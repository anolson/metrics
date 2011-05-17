class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :verify_user_authentication

  helper_method :has_authenticated?
  helper_method :current_user

  private
    def verify_user_authentication
      unless has_authenticated?
        session[:return_to] = request.fullpath
        redirect_to login_path
      end
    end

    def current_user
      remember_user
      @current_user ||= User.find(session[:user]) if has_authenticated?
    end

    def has_authenticated?
      session[:user] != nil
    end

    def remember_user
      session[:user] = cookies.signed[:remember_me] if cookies.signed[:remember_me]
    end

    def setup_session(user)
      session[:user] = user.id
      redirect_to_intended_path(user)
    end

    def redirect_to_intended_path(user)
      session[:return_to] ? redirect_to(session[:return_to]) : redirect_to(root_path)
      session[:return_to] = nil
    end
end
