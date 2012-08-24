require 'test_helper'

class MClassChecksControllerTest < ActionController::TestCase
  setup do
    @m_class_check = m_class_checks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:m_class_checks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create m_class_check" do
    assert_difference('MClassCheck.count') do
      post :create, m_class_check: @m_class_check.attributes
    end

    assert_redirected_to m_class_check_path(assigns(:m_class_check))
  end

  test "should show m_class_check" do
    get :show, id: @m_class_check.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @m_class_check.to_param
    assert_response :success
  end

  test "should update m_class_check" do
    put :update, id: @m_class_check.to_param, m_class_check: @m_class_check.attributes
    assert_redirected_to m_class_check_path(assigns(:m_class_check))
  end

  test "should destroy m_class_check" do
    assert_difference('MClassCheck.count', -1) do
      delete :destroy, id: @m_class_check.to_param
    end

    assert_redirected_to m_class_checks_path
  end
end
