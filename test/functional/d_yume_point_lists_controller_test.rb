require 'test_helper'

class DYumePointListsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get search" do
    get :search
    assert_response :success
  end

  test "should get print" do
    get :print
    assert_response :success
  end

end
