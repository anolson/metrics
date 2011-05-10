class Ride < ActiveRecord::Base
  belongs_to :user
  
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
    fetch_ride
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
  
    def fetch_ride
      fetch_ride_summary
      fetch_ride_streams  
    end
    
    def fetch_ride_summary
      ride = strava_api.ride_show(self.strava_ride_id.to_i)
      
      write_attribute(:name, ride[:name])
      write_attribute(:date, ride[:start_date_local])
    end
    
    def fetch_ride_streams
      streams = strava_api.ride_streams(self.strava_ride_id.to_i)
      
      unless(streams.watts.empty?)
        @watts = streams.watts.collect { |item| item.nil? && 0 || item }
      end
    end
    
    def strava_api
      @strava_api ||= StravaApi::Base.new
    end
    

  
end
