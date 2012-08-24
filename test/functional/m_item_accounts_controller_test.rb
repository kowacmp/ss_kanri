require 'test_helper'

class MItemAccountsControllerTest < ActionController::TestCase
  setup do
    @m_item_account = m_item_accounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:m_item_accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create m_item_account" do
    assert_difference('MItemAccount.count') do
      post :create, m_item_account: @m_item_account.attributes
    end

    assert_redirected_to m_item_account_path(assigns(:m_item_account))
  end

  test "should show m_item_account" do
    get :show, id: @m_item_account.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @m_item_account.to_param
    assert_response :success
  end

  test "should update m_item_account" do
    put :update, id: @m_item_account.to_param, m_item_account: @m_item_account.attributes
    assert_redirected_to m_item_account_path(assigns(:m_item_account))
  end

  test "should destroy m_item_account" do
    assert_difference('MItemAccount.count', -1) do
      delete :destroy, id: @m_item_account.to_param
    end

    assert_redirected_to m_item_accounts_path
  end
end
