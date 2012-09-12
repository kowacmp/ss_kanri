require 'test_helper'

class MEtcShopsControllerTest < ActionController::TestCase
  setup do
    @m_etc_shop = m_etc_shops(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:m_etc_shops)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create m_etc_shop" do
    assert_difference('MEtcShop.count') do
      post :create, m_etc_shop: @m_etc_shop.attributes
    end

    assert_redirected_to m_etc_shop_path(assigns(:m_etc_shop))
  end

  test "should show m_etc_shop" do
    get :show, id: @m_etc_shop.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @m_etc_shop.to_param
    assert_response :success
  end

  test "should update m_etc_shop" do
    put :update, id: @m_etc_shop.to_param, m_etc_shop: @m_etc_shop.attributes
    assert_redirected_to m_etc_shop_path(assigns(:m_etc_shop))
  end

  test "should destroy m_etc_shop" do
    assert_difference('MEtcShop.count', -1) do
      delete :destroy, id: @m_etc_shop.to_param
    end

    assert_redirected_to m_etc_shops_path
  end
end
