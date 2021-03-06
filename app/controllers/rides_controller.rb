class RidesController < ApplicationController
  skip_before_filter :verify_user_authentication, :only => 'index'

  respond_to :js, :html, :json

  def index
    if has_authenticated?
      respond_with(@rides = current_user.strava_rides(params[:page].to_i))
    else
      render :template => "site/index"
    end
  end
  
  def show
    @ride = Ride.find_or_create_by_strava_ride_id(:strava_ride_id => params[:id], :user => current_user)
    @ride.sync
    respond_with(@ride)
  end
  
end
