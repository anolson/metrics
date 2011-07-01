class User < ActiveRecord::Base
  has_many :rides
  
  validates_presence_of :email, :password, :threshold_power
  validates_uniqueness_of :strava_athlete_id
  
  before_validation :create_user_from_strava 
  
  attr_accessor :email, :password
  
  def self.authenticate(options = {})
    strava_user = authenticate_with_strava(options[:email], options[:password])
    User.find_by_strava_athlete_id(strava_user.athlete_id)
  end
  
  def create_user_from_strava()
    strava_user = authenticate_with_strava(@email, @password)
    self.strava_athlete_id = strava_user.athlete_id
    self.strava_api_token = strava_user.token  
  end

  def self.authenticate_with_strava(email, password)
    User.new.strava_api.login(email, password)
  end

  def authenticate_with_strava(email, password)
    strava_api.login(email, password)
  end

  def strava_rides(offset = 0)
    p offset
    fetch_rides_from_strava(offset).collect { |ride|
      Ride.find_or_create_by_strava_ride_id(:strava_ride_id => ride.id, :name => ride.name, :user => self)
    }
  end

  def fetch_rides_from_strava(offset)
    offset = 0 if(offset.nil?)
    strava_api.rides(:athlete_id => self.strava_athlete_id, :start_id => 0, :offset => offset * 50)
  end

  def strava_api
    @strava_api ||= StravaApi::Base.new
  end
end
