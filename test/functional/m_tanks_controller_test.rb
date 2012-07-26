require 'test_helper'

class MTanksControllerTest < ActionController::TestCase
  setup do
    @m_tank = m_tanks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:m_tanks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create m_tank" do
    assert_difference('MTank.count') do
      post :create, m_tank: @m_tank.attributes
    end

    assert_redirected_to m_tank_path(assigns(:m_tank))
  end

  test "should show m_tank" do
    get :show, id: @m_tank.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @m_tank.to_param
    assert_response :success
  end

  test "should update m_tank" do
    put :update, id: @m_tank.to_param, m_tank: @m_tank.attributes
    assert_redirected_to m_tank_path(assigns(:m_tank))
  end

  test "should destroy m_tank" do
    assert_difference('MTank.count', -1) do
      delete :destroy, id: @m_tank.to_param
    end

    assert_redirected_to m_tanks_path
  end
end
