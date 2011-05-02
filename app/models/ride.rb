class Ride < ActiveRecord::Base
  
  attr_accessor :strava_ride_id
  attr_writer :watts
  
  def calculate_normalized_power
    normalized_power = Joule::Calculator::PowerCalculator.normalized_power(watts, record_interval)
    write_attribute(:normalized_power, normalized_power)
  end
  
  def watts
    @watts ||= fetch_watts_from_strava
  end
  
  def record_interval
    1
  end
  
  def fetch_watts_from_strava
    fetch_ride_streams_from_strava.watts.collect { |item| item.nil? && 0 || item}
  end
  
  def fetch_ride_streams_from_strava
    strava = StravaApi::Base.new
    strava.ride_streams(@strava_ride_id)
  end
  
end
