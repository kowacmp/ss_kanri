require 'test_helper'

class MEtcsalesControllerTest < ActionController::TestCase
  setup do
    @m_etcsale = m_etcsales(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:m_etcsales)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create m_etcsale" do
    assert_difference('MEtcsale.count') do
      post :create, m_etcsale: @m_etcsale.attributes
    end

    assert_redirected_to m_etcsale_path(assigns(:m_etcsale))
  end

  test "should show m_etcsale" do
    get :show, id: @m_etcsale.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @m_etcsale.to_param
    assert_response :success
  end

  test "should update m_etcsale" do
    put :update, id: @m_etcsale.to_param, m_etcsale: @m_etcsale.attributes
    assert_redirected_to m_etcsale_path(assigns(:m_etcsale))
  end

  test "should destroy m_etcsale" do
    assert_difference('MEtcsale.count', -1) do
      delete :destroy, id: @m_etcsale.to_param
    end

    assert_redirected_to m_etcsales_path
  end
end
