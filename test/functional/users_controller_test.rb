require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "a new user" do
    get(:new)
    assert_response :success
  end
  
  test "create a new user" do
    post(:create, :user => {:email => "me@here.com", :password => "secret", :threshold_power => 200})
    assert_redirected_to user_path(assigns(:user))
  end
end
