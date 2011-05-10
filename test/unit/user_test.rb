require 'test_helper'
require 'pp'
class UserTest < ActiveSupport::TestCase
  test "create a new user" do
    
    user = User.new(:strava_athlete_id => 1234, :threshold_power => 200)
    assert_equal 1234, user.strava_athlete_id
    assert_equal 200, user.threshold_power
  end
end
