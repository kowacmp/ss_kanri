require 'test_helper'

class MOilsControllerTest < ActionController::TestCase
  setup do
    @m_oil = m_oils(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:m_oils)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create m_oil" do
    assert_difference('MOil.count') do
      post :create, m_oil: @m_oil.attributes
    end

    assert_redirected_to m_oil_path(assigns(:m_oil))
  end

  test "should show m_oil" do
    get :show, id: @m_oil.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @m_oil.to_param
    assert_response :success
  end

  test "should update m_oil" do
    put :update, id: @m_oil.to_param, m_oil: @m_oil.attributes
    assert_redirected_to m_oil_path(assigns(:m_oil))
  end

  test "should destroy m_oil" do
    assert_difference('MOil.count', -1) do
      delete :destroy, id: @m_oil.to_param
    end

    assert_redirected_to m_oils_path
  end
end
