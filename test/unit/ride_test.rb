require 'test_helper'

class RideTest < ActiveSupport::TestCase
  
  test "creating a new ride without any metrics" do
    ride = Ride.new
    assert_equal 0.0, ride.normalized_power
    assert_equal 0.0, ride.training_stress_score
    assert_equal 0.0, ride.intensity_factor
  end
  
  test "creating a new ride with metrics" do
    ride = Ride.new :normalized_power => 234.0, :training_stress_score => 90.3, :intensity_factor => 0.8
    assert_equal 234.0, ride.normalized_power
    assert_equal 90.3, ride.training_stress_score
    assert_equal 0.8, ride.intensity_factor
  end
  
  test "finding a ride without any metrics" do
    ride = Ride.find(1)
    assert_equal 0.0, ride.normalized_power
    assert_equal 0.0, ride.training_stress_score
    assert_equal 0.0, ride.intensity_factor
  end
  
  test "finding a ride with metrics" do
    ride = Ride.find(2)
    assert_equal 234.0, ride.normalized_power
    assert_equal 90.3, ride.training_stress_score
    assert_equal 0.8, ride.intensity_factor
  end

  test "calculate metrics for a ride without any power values" do 
    ride = Ride.new
    ride.calculate_metrics(320)
    assert_equal 0.0, ride.normalized_power.round(2)
    assert_equal 0.0, ride.training_stress_score.round(2)
    assert_equal 0.0, ride.intensity_factor.round(1)
  end

  test "syncing a ride from strava" do 
    ride = Ride.new
    ride.sync(486125, 320)
    assert_equal 288.46, ride.normalized_power.round(2)
    assert_equal 148.68, ride.training_stress_score.round(2)
    assert_equal 0.9, ride.intensity_factor.round(1)
  end
  
end
