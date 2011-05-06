class RidesController < ApplicationController
  
  def show
    @ride = Ride.find_by_strava_ride_id(params[:id])
  end
  
end
