require 'test_helper'

class MWashsalePlansControllerTest < ActionController::TestCase
  setup do
    @m_washsale_plan = m_washsale_plans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:m_washsale_plans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create m_washsale_plan" do
    assert_difference('MWashsalePlan.count') do
      post :create, m_washsale_plan: @m_washsale_plan.attributes
    end

    assert_redirected_to m_washsale_plan_path(assigns(:m_washsale_plan))
  end

  test "should show m_washsale_plan" do
    get :show, id: @m_washsale_plan.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @m_washsale_plan.to_param
    assert_response :success
  end

  test "should update m_washsale_plan" do
    put :update, id: @m_washsale_plan.to_param, m_washsale_plan: @m_washsale_plan.attributes
    assert_redirected_to m_washsale_plan_path(assigns(:m_washsale_plan))
  end

  test "should destroy m_washsale_plan" do
    assert_difference('MWashsalePlan.count', -1) do
      delete :destroy, id: @m_washsale_plan.to_param
    end

    assert_redirected_to m_washsale_plans_path
  end
end
