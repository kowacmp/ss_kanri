require 'test_helper'

class DWashsaleReportsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get search" do
    get :search
    assert_response :success
  end

  test "should get update" do
    get :update
    assert_response :success
  end

end