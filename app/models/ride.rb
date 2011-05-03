class Ride < ActiveRecord::Base
  
  attr_accessor :watts
  # attr_writer :watts
  
  def initialize(options = {})
    super options
    @watts = []
  end
  
  def sync(strava_ride_id, threshold_power = 0)
    @watts = fetch_watts_from_strava(strava_ride_id)
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
  
    def fetch_watts_from_strava(strava_ride_id)
      streams = fetch_ride_streams_from_strava(strava_ride_id)

      unless(streams.watts.empty?)
        streams.watts.collect { |item| item.nil? && 0 || item }
      end
    end
    
    def fetch_ride_streams_from_strava(strava_ride_id)
      strava = StravaApi::Base.new
      strava.ride_streams(strava_ride_id)
    end
  
end
