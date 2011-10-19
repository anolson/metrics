class Ride < ActiveRecord::Base
  # after_create :sync_ride
  belongs_to :user

  attr_accessor :watts, :seconds

  def sync
    unless synced?
      fetch_ride
      calculate_metrics
      update_attributes(:synced => true)
    end
  end

  def record_interval
    1
  end

  def duration_seconds
    record_interval * watts.size
  end

  private
    def calculate_metrics
      @watts = [] if @watts.nil?
      calculate_normalized_power
      calculate_training_stress_score
      calculate_intensity_factor
    end

    def calculate_normalized_power
      np = Joule::Calculator::PowerCalculator.normalized_power(watts, record_interval)
      write_attribute(:normalized_power, np)
    end

    def calculate_training_stress_score
      tss = Joule::Calculator::PowerCalculator.training_stress_score(duration_seconds, self.normalized_power, self.user.threshold_power)
      write_attribute(:training_stress_score, tss)
    end

    def calculate_intensity_factor
      intensity_factor = Joule::Calculator::PowerCalculator.intensity_factor(self.normalized_power, self.user.threshold_power)
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

      @seconds = streams.time
      @watts = streams.watts.collect { |item| item.nil? && 0 || item } unless (streams.watts.nil?)
    end

    def strava_api
      @strava_api ||= StravaApi::Base.new
    end
end
