require 'test_helper'

class MGetPointsControllerTest < ActionController::TestCase
  setup do
    @m_get_point = m_get_points(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:m_get_points)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create m_get_point" do
    assert_difference('MGetPoint.count') do
      post :create, m_get_point: @m_get_point.attributes
    end

    assert_redirected_to m_get_point_path(assigns(:m_get_point))
  end

  test "should show m_get_point" do
    get :show, id: @m_get_point.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @m_get_point.to_param
    assert_response :success
  end

  test "should update m_get_point" do
    put :update, id: @m_get_point.to_param, m_get_point: @m_get_point.attributes
    assert_redirected_to m_get_point_path(assigns(:m_get_point))
  end

  test "should destroy m_get_point" do
    assert_difference('MGetPoint.count', -1) do
      delete :destroy, id: @m_get_point.to_param
    end

    assert_redirected_to m_get_points_path
  end
end
