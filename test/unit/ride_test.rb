require 'test_helper'

class RideTest < ActiveSupport::TestCase
  
  test "test a new ride without any metrics" do
    ride = Ride.new
    assert_equal 0.0, ride.normalized_power
    assert_equal 0.0, ride.training_stress_score
    assert_equal 0.0, ride.intensity_factor
  end
  
  test "test a new ride with metrics" do
    ride = Ride.new :normalized_power => 234.0, :training_stress_score => 90.3, :intensity_factor => 0.8
    assert_equal 234.0, ride.normalized_power
    assert_equal 90.3, ride.training_stress_score
    assert_equal 0.8, ride.intensity_factor
  end
  
  test "test find a ride without any metrics" do
    ride = Ride.find(1)
    assert_equal 0.0, ride.normalized_power
    assert_equal 0.0, ride.training_stress_score
    assert_equal 0.0, ride.intensity_factor
  end
  
  test "test find a ride with metrics" do
    ride = Ride.find(2)
    assert_equal 234.0, ride.normalized_power
    assert_equal 90.3, ride.training_stress_score
    assert_equal 0.8, ride.intensity_factor
  end
  
  test "test normalized power calculation for a ride without power values" do
    ride = Ride.new 
    ride.watts = []
    ride.calculate_normalized_power
    assert_equal 0.0, ride.normalized_power
  end

  test "fetch watts for a ride from strava" do
    ride = Ride.new :strava_ride_id => 486125
    ride.fetch_watts_from_strava
    assert_not_nil ride.watts
  end
  
  test "test normalized power calculation for a ride fetched from strava" do
    ride = Ride.new :strava_ride_id => 486125
    ride.calculate_normalized_power
    assert_equal 288.46, ride.normalized_power.round(2)
  end
  
end
