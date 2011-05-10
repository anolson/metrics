class User < ActiveRecord::Base
  has_many :rides
  
  attr_accessor :email, :password
  
  def authenticate!
    strava_user = strava_api.login(@email, @password)
    self.username = @email.split('@').first
    self.strava_athlete_id = strava_user.athlete_id
    self.strava_api_token = strava_user.token
  end
  
  def strava_api
    @strava_api ||= StravaApi::Base.new
  end
end
