require 'test_helper'

class DWashSalesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get entry_error" do
    get :entry_error
    assert_response :success
  end

end
