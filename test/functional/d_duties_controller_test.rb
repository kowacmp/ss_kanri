require 'test_helper'

class DDutiesControllerTest < ActionController::TestCase
  setup do
    @d_duty = d_duties(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:d_duties)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create d_duty" do
    assert_difference('DDuty.count') do
      post :create, d_duty: @d_duty.attributes
    end

    assert_redirected_to d_duty_path(assigns(:d_duty))
  end

  test "should show d_duty" do
    get :show, id: @d_duty.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @d_duty.to_param
    assert_response :success
  end

  test "should update d_duty" do
    put :update, id: @d_duty.to_param, d_duty: @d_duty.attributes
    assert_redirected_to d_duty_path(assigns(:d_duty))
  end

  test "should destroy d_duty" do
    assert_difference('DDuty.count', -1) do
      delete :destroy, id: @d_duty.to_param
    end

    assert_redirected_to d_duties_path
  end
end
