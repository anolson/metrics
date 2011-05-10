class User < ActiveRecord::Base
  has_many :rides
  
  validates_uniqueness_of :strava_athlete_id, :username
  
  before_validation :create_user_from_strava 
  
  attr_accessor :email, :password
  
  def self.authenticate(options = {})
    strava_user = authenticate_with_strava(option[:email], options[:password])
    User.find_by_athlete_id(strava_user.athlete_id)
  end
  
  def create_user_from_strava()
    strava_user = authenticate_with_strava(@email, @password)
    self.username = @email.split('@').first
    self.strava_athlete_id = strava_user.athlete_id
    self.strava_api_token = strava_user.token  
  end
  
  def authenticate_with_strava(email, password)
    strava_api.login(email, password)
  end
  
  def strava_rides
    strava_api.rides(:athlete_id => self.strava_athlete_id)
  end
  
  def strava_api
    @strava_api ||= StravaApi::Base.new
  end
end
