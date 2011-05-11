class SessionController < ApplicationController
  
  def new; end
  
  def create
    user = User.authenticate(params[:user])      
    session[:user] = user.id
    redirect_to permalink_path(user.username)
  rescue StravaApi::AuthenticationError => e
    redirect_to new_session_path, :alert => 'Invalid email or password.'
  end
  
  def destroy
    reset_session
    redirect_to root_path
  end
  
end
