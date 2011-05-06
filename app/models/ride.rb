class Ride < ActiveRecord::Base
  
  attr_accessor :watts
  
  def initialize(options = {})
    super options
    @watts = []
  end
  
  def self.find_by_strava_ride_id(strava_ride_id, sync = true)
    ride = super(strava_ride_id)
    
    if(ride.nil? && sync)
      ride = Ride.new :strava_ride_id => strava_ride_id
      ride.sync(320)
      ride.save
    end
    
    return ride
  end
  
  def sync(threshold_power = 0)
    @watts = fetch_watts_from_strava
    calculate_metrics(threshold_power)
  end
  
  def calculate_metrics(threshold_power = 0)
    calculate_normalized_power
    calculate_training_stress_score(threshold_power)
    calculate_intensity_factor(threshold_power)
  end
  
  def record_interval
    1
  end
  
  def duration_seconds
    record_interval * watts.size
  end
  
  private
    
    def calculate_normalized_power
      np = Joule::Calculator::PowerCalculator.normalized_power(watts, record_interval)
      write_attribute(:normalized_power, np)
    end
  
    def calculate_training_stress_score(threshold_power)
      tss = Joule::Calculator::PowerCalculator.training_stress_score(duration_seconds, self.normalized_power, threshold_power)
      write_attribute(:training_stress_score, tss)
    end
    
    def calculate_intensity_factor(threshold_power)
      intensity_factor = Joule::Calculator::PowerCalculator.intensity_factor(self.normalized_power, threshold_power)
      write_attribute(:intensity_factor, intensity_factor)
    end
  
    def fetch_watts_from_strava
      streams = fetch_ride_streams_from_strava
      
      unless(streams.watts.empty?)
        streams.watts.collect { |item| item.nil? && 0 || item }
      end
    end
    
    def fetch_ride_streams_from_strava
      strava = StravaApi::Base.new
      strava.ride_streams(self.strava_ride_id.to_i)
    end
  
end
