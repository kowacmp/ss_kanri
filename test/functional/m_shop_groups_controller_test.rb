require 'test_helper'

class MShopGroupsControllerTest < ActionController::TestCase
  setup do
    @m_shop_group = m_shop_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:m_shop_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create m_shop_group" do
    assert_difference('MShopGroup.count') do
      post :create, m_shop_group: @m_shop_group.attributes
    end

    assert_redirected_to m_shop_group_path(assigns(:m_shop_group))
  end

  test "should show m_shop_group" do
    get :show, id: @m_shop_group.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @m_shop_group.to_param
    assert_response :success
  end

  test "should update m_shop_group" do
    put :update, id: @m_shop_group.to_param, m_shop_group: @m_shop_group.attributes
    assert_redirected_to m_shop_group_path(assigns(:m_shop_group))
  end

  test "should destroy m_shop_group" do
    assert_difference('MShopGroup.count', -1) do
      delete :destroy, id: @m_shop_group.to_param
    end

    assert_redirected_to m_shop_groups_path
  end
end
