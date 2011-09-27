require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "a new user" do
    get(:new)
    assert_response :success
  end
  
  test "create a new user" do
    strava_user = mock()
    strava_user.expects(:athlete_id).returns("1")
    strava_user.expects(:token).returns("token")
    
    User.any_instance.stubs(:authenticate_with_strava).returns(strava_user)
    
    post(:create, :user => {:email => "me@here.com", :password => "secret", :threshold_power => 200})
    assert_redirected_to root_path
  end
end
