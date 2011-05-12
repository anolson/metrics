class SessionController < ApplicationController
  
  skip_filter :verify_user_authentication, :only => [:new, :create]
  
  def new; end
  
  def create
    user = User.authenticate(params[:user])      
    setup_session(user)
  rescue StravaApi::AuthenticationError => e
    redirect_to new_session_path, :alert => 'Invalid email or password.'
  end
  
  def destroy
    reset_session
    redirect_to root_path
  end
  
end
