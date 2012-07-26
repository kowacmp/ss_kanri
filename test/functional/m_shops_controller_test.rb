require 'test_helper'

class MShopsControllerTest < ActionController::TestCase
  setup do
    @m_shop = m_shops(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:m_shops)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create m_shop" do
    assert_difference('MShop.count') do
      post :create, m_shop: @m_shop.attributes
    end

    assert_redirected_to m_shop_path(assigns(:m_shop))
  end

  test "should show m_shop" do
    get :show, id: @m_shop.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @m_shop.to_param
    assert_response :success
  end

  test "should update m_shop" do
    put :update, id: @m_shop.to_param, m_shop: @m_shop.attributes
    assert_redirected_to m_shop_path(assigns(:m_shop))
  end

  test "should destroy m_shop" do
    assert_difference('MShop.count', -1) do
      delete :destroy, id: @m_shop.to_param
    end

    assert_redirected_to m_shops_path
  end
end
