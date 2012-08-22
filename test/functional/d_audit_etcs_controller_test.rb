require 'test_helper'

class DAuditEtcsControllerTest < ActionController::TestCase
  setup do
    @d_audit_etc = d_audit_etcs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:d_audit_etcs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create d_audit_etc" do
    assert_difference('DAuditEtc.count') do
      post :create, d_audit_etc: @d_audit_etc.attributes
    end

    assert_redirected_to d_audit_etc_path(assigns(:d_audit_etc))
  end

  test "should show d_audit_etc" do
    get :show, id: @d_audit_etc.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @d_audit_etc.to_param
    assert_response :success
  end

  test "should update d_audit_etc" do
    put :update, id: @d_audit_etc.to_param, d_audit_etc: @d_audit_etc.attributes
    assert_redirected_to d_audit_etc_path(assigns(:d_audit_etc))
  end

  test "should destroy d_audit_etc" do
    assert_difference('DAuditEtc.count', -1) do
      delete :destroy, id: @d_audit_etc.to_param
    end

    assert_redirected_to d_audit_etcs_path
  end
end
