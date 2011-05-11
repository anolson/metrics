class SessionController < ApplicationController
  
  def new; end
  
  def create
    user = User.authenticate(params[:user])      
    session[:user] = user.id
    redirect_to(user)
  # rescue
  #   redirect_to signin_path, :notice => 'Invalid email or password.'
  end
  
  def destroy
    reset_session
    redirect_to root_path
  end
  
end
