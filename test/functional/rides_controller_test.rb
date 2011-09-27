require 'test_helper'

class RidesControllerTest < ActionController::TestCase
  test "show a ride" do 
    get(:show, {'id' => 486125}, {:user => 1})
    assert_response :success
  end
end
