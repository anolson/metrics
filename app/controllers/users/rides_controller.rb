class Users::RidesController < ApplicationController
    
  def index
    @rides = @current_user.strava_rides
  end
  
  def show
    @ride = Ride.find_by_strava_ride_id(params[:id])
    if(@ride.nil?)
      @ride = Ride.new(:strava_ride_id => params[:id])
      @ride.sync(@current_user.threshold_power)
    end
  end
  
end
