class SessionController < ApplicationController
  
  skip_filter :verify_user_authentication, :only => [:new, :create]
  
  def new; end
  
  def create
    user = User.authenticate(params[:user])      
    if user
      setup_session(user)
      cookies.permanent.signed[:remember_me] = user.id if params[:remember_me]
    else
      redirect_with_error
    end

  rescue StravaApi::AuthenticationError => e
    redirect_with_error
  end
  
  def destroy
    cookies.delete :remember_me
    reset_session
    redirect_to root_path
  end
  
  private
    def redirect_with_error
      redirect_to login_path, :alert => 'Invalid email or password.'
    end
  
end
