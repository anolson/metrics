class Users::RidesController < ApplicationController
    
  respond_to :html, :json
  
  def index
    respond_with(@rides = @current_user.strava_rides)
  end
  
  def show
    @ride = Ride.find_by_strava_ride_id(params[:id])
    if(@ride.nil?)
      @ride = Ride.new(:strava_ride_id => params[:id])
      @ride.sync(@current_user)
    end
    respond_with(@ride)
  end
  
end
