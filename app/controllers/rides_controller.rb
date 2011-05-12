class RidesController < ApplicationController
  
  skip_filter :verify_user_authentication
  
  def show
    @ride = Ride.find_by_strava_ride_id(params[:id])
  end
  
end
