require 'test_helper'

class MWashesControllerTest < ActionController::TestCase
  setup do
    @m_wash = m_washes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:m_washes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create m_wash" do
    assert_difference('MWash.count') do
      post :create, m_wash: @m_wash.attributes
    end

    assert_redirected_to m_wash_path(assigns(:m_wash))
  end

  test "should show m_wash" do
    get :show, id: @m_wash.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @m_wash.to_param
    assert_response :success
  end

  test "should update m_wash" do
    put :update, id: @m_wash.to_param, m_wash: @m_wash.attributes
    assert_redirected_to m_wash_path(assigns(:m_wash))
  end

  test "should destroy m_wash" do
    assert_difference('MWash.count', -1) do
      delete :destroy, id: @m_wash.to_param
    end

    assert_redirected_to m_washes_path
  end
end
