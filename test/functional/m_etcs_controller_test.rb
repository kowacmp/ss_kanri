require 'test_helper'

class MEtcsControllerTest < ActionController::TestCase
  setup do
    @m_etc = m_etcs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:m_etcs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create m_etc" do
    assert_difference('MEtc.count') do
      post :create, m_etc: @m_etc.attributes
    end

    assert_redirected_to m_etc_path(assigns(:m_etc))
  end

  test "should show m_etc" do
    get :show, id: @m_etc.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @m_etc.to_param
    assert_response :success
  end

  test "should update m_etc" do
    put :update, id: @m_etc.to_param, m_etc: @m_etc.attributes
    assert_redirected_to m_etc_path(assigns(:m_etc))
  end

  test "should destroy m_etc" do
    assert_difference('MEtc.count', -1) do
      delete :destroy, id: @m_etc.to_param
    end

    assert_redirected_to m_etcs_path
  end
end
