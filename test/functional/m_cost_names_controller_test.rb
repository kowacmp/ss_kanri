require 'test_helper'

class MCostNamesControllerTest < ActionController::TestCase
  setup do
    @m_cost_name = m_cost_names(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:m_cost_names)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create m_cost_name" do
    assert_difference('MCostName.count') do
      post :create, m_cost_name: @m_cost_name.attributes
    end

    assert_redirected_to m_cost_name_path(assigns(:m_cost_name))
  end

  test "should show m_cost_name" do
    get :show, id: @m_cost_name.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @m_cost_name.to_param
    assert_response :success
  end

  test "should update m_cost_name" do
    put :update, id: @m_cost_name.to_param, m_cost_name: @m_cost_name.attributes
    assert_redirected_to m_cost_name_path(assigns(:m_cost_name))
  end

  test "should destroy m_cost_name" do
    assert_difference('MCostName.count', -1) do
      delete :destroy, id: @m_cost_name.to_param
    end

    assert_redirected_to m_cost_names_path
  end
end
