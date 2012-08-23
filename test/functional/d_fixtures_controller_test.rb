require 'test_helper'

class DFixturesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get updete" do
    get :updete
    assert_response :success
  end

end
