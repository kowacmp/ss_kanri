require 'test_helper'

class DPriceChecksControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get entry_price" do
    get :entry_price
    assert_response :success
  end

  test "should get entry_other_price" do
    get :entry_other_price
    assert_response :success
  end

end
