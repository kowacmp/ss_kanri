require 'test_helper'

class DAuditWashesControllerTest < ActionController::TestCase
  setup do
    @d_audit_wash = d_audit_washes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:d_audit_washes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create d_audit_wash" do
    assert_difference('DAuditWash.count') do
      post :create, d_audit_wash: @d_audit_wash.attributes
    end

    assert_redirected_to d_audit_wash_path(assigns(:d_audit_wash))
  end

  test "should show d_audit_wash" do
    get :show, id: @d_audit_wash.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @d_audit_wash.to_param
    assert_response :success
  end

  test "should update d_audit_wash" do
    put :update, id: @d_audit_wash.to_param, d_audit_wash: @d_audit_wash.attributes
    assert_redirected_to d_audit_wash_path(assigns(:d_audit_wash))
  end

  test "should destroy d_audit_wash" do
    assert_difference('DAuditWash.count', -1) do
      delete :destroy, id: @d_audit_wash.to_param
    end

    assert_redirected_to d_audit_washes_path
  end
end
