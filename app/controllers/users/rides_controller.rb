class Users::RidesController < ApplicationController
    
  respond_to :html, :json
  
  def index
    respond_with(@rides = @current_user.strava_rides)
  end
  
  def show
    @ride = Ride.find_or_create_by_strava_ride_id(:strava_ride_id => params[:id], :user => @current_user)
    @ride.sync() unless @ride.synced
    respond_with(@ride)
  end
  
end
