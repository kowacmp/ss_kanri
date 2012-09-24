require 'test_helper'

class DResultTankListsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get csv" do
    get :csv
    assert_response :success
  end

end
