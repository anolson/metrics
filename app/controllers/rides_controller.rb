class RidesController < ApplicationController
  skip_before_filter :verify_user_authentication, :only => 'index'
    
  respond_to :html, :json
  
  def index
    if has_authenticated?
      respond_with(@rides = @current_user.strava_rides)
    else
      render :template => "site/index"
    end
  end
  
  def show
    @ride = Ride.find_or_create_by_strava_ride_id(:strava_ride_id => params[:id], :user => @current_user)
    @ride.sync() unless @ride.synced
    respond_with(@ride)
  end
  
end
