class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    @user.authenticate!
    
    if @user.save
      redirect_to(@user)
    else
      render :action => "new"
    end
  end
  
  def show
    if(params[:id])
      @user = User.find(params[:id])
    else
      @user = User.where(:username => params[:username]).first
    end
    
  end
end
