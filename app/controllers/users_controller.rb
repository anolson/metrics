class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      session[:user] = @user.id
      redirect_to users_rides_path(@user.username)
    else
      render :action => "new"
    end
  rescue StravaApi::AuthenticationError => e
    redirect_to new_user_path, :alert => 'Invalid email or password.'
  end
  
end
