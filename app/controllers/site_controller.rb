class SiteController < ApplicationController
  skip_filter :verify_user_authentication

  def index
    redirect_to users_rides_path(@current_user.username) if @current_user
  end
end
