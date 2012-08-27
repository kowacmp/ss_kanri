require 'test_helper'

class MApprovalsControllerTest < ActionController::TestCase
  setup do
    @m_approval = m_approvals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:m_approvals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create m_approval" do
    assert_difference('MApproval.count') do
      post :create, m_approval: @m_approval.attributes
    end

    assert_redirected_to m_approval_path(assigns(:m_approval))
  end

  test "should show m_approval" do
    get :show, id: @m_approval.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @m_approval.to_param
    assert_response :success
  end

  test "should update m_approval" do
    put :update, id: @m_approval.to_param, m_approval: @m_approval.attributes
    assert_redirected_to m_approval_path(assigns(:m_approval))
  end

  test "should destroy m_approval" do
    assert_difference('MApproval.count', -1) do
      delete :destroy, id: @m_approval.to_param
    end

    assert_redirected_to m_approvals_path
  end
end
