require 'test_helper'

class SiteControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  test "the main site index page" do
    get :index
    assert_response :success
  end
end
