class Users::RidesController < ApplicationController
  
  before_filter :find_user
  
  def index; end
  
  def show
    @ride = Ride.find_by_strava_ride_id(params[:id])
  end
  
  private 
    def find_user
      @user ||= User.where(:username => params[:username]).first
    end
  
end
