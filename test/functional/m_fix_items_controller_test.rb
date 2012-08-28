require 'test_helper'

class MFixItemsControllerTest < ActionController::TestCase
  setup do
    @m_fix_item = m_fix_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:m_fix_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create m_fix_item" do
    assert_difference('MFixItem.count') do
      post :create, m_fix_item: @m_fix_item.attributes
    end

    assert_redirected_to m_fix_item_path(assigns(:m_fix_item))
  end

  test "should show m_fix_item" do
    get :show, id: @m_fix_item.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @m_fix_item.to_param
    assert_response :success
  end

  test "should update m_fix_item" do
    put :update, id: @m_fix_item.to_param, m_fix_item: @m_fix_item.attributes
    assert_redirected_to m_fix_item_path(assigns(:m_fix_item))
  end

  test "should destroy m_fix_item" do
    assert_difference('MFixItem.count', -1) do
      delete :destroy, id: @m_fix_item.to_param
    end

    assert_redirected_to m_fix_items_path
  end
end
