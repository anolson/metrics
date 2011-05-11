class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      session[:user] = @user.id
      redirect_to permalink_path(@user.username)
    else
      render :action => "new"
    end
  rescue StravaApi::AuthenticationError => e
    redirect_to new_user_path, :alert => 'Invalid email or password.'
  end
  
  def show
    if(params[:id])
      @user = User.find(params[:id])
    else
      @user = User.where(:username => params[:username]).first
    end
    
  end
end
