require 'test_helper'

class MAuditChecksControllerTest < ActionController::TestCase
  setup do
    @m_audit_check = m_audit_checks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:m_audit_checks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create m_audit_check" do
    assert_difference('MAuditCheck.count') do
      post :create, m_audit_check: @m_audit_check.attributes
    end

    assert_redirected_to m_audit_check_path(assigns(:m_audit_check))
  end

  test "should show m_audit_check" do
    get :show, id: @m_audit_check.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @m_audit_check.to_param
    assert_response :success
  end

  test "should update m_audit_check" do
    put :update, id: @m_audit_check.to_param, m_audit_check: @m_audit_check.attributes
    assert_redirected_to m_audit_check_path(assigns(:m_audit_check))
  end

  test "should destroy m_audit_check" do
    assert_difference('MAuditCheck.count', -1) do
      delete :destroy, id: @m_audit_check.to_param
    end

    assert_redirected_to m_audit_checks_path
  end
end
