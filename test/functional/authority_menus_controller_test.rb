require 'test_helper'

class AuthorityMenusControllerTest < ActionController::TestCase
  setup do
    @authority_menu = authority_menus(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:authority_menus)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create authority_menu" do
    assert_difference('AuthorityMenu.count') do
      post :create, authority_menu: @authority_menu.attributes
    end

    assert_redirected_to authority_menu_path(assigns(:authority_menu))
  end

  test "should show authority_menu" do
    get :show, id: @authority_menu.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @authority_menu.to_param
    assert_response :success
  end

  test "should update authority_menu" do
    put :update, id: @authority_menu.to_param, authority_menu: @authority_menu.attributes
    assert_redirected_to authority_menu_path(assigns(:authority_menu))
  end

  test "should destroy authority_menu" do
    assert_difference('AuthorityMenu.count', -1) do
      delete :destroy, id: @authority_menu.to_param
    end

    assert_redirected_to authority_menus_path
  end
end
