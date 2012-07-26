require 'test_helper'

class MInfoCostsControllerTest < ActionController::TestCase
  setup do
    @m_info_cost = m_info_costs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:m_info_costs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create m_info_cost" do
    assert_difference('MInfoCost.count') do
      post :create, m_info_cost: @m_info_cost.attributes
    end

    assert_redirected_to m_info_cost_path(assigns(:m_info_cost))
  end

  test "should show m_info_cost" do
    get :show, id: @m_info_cost.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @m_info_cost.to_param
    assert_response :success
  end

  test "should update m_info_cost" do
    put :update, id: @m_info_cost.to_param, m_info_cost: @m_info_cost.attributes
    assert_redirected_to m_info_cost_path(assigns(:m_info_cost))
  end

  test "should destroy m_info_cost" do
    assert_difference('MInfoCost.count', -1) do
      delete :destroy, id: @m_info_cost.to_param
    end

    assert_redirected_to m_info_costs_path
  end
end
