class UsersController < ApplicationController

  skip_filter :verify_user_authentication, :only => [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      setup_session(@user)
    else
      render :action => "new"
    end
  rescue StravaApi::AuthenticationError => e
    redirect_to new_users_path, :alert => 'Invalid email or password.'
  end

end
