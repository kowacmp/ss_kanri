require 'test_helper'

class EstablishesControllerTest < ActionController::TestCase
  setup do
    @establish = establishes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:establishes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create establish" do
    assert_difference('Establish.count') do
      post :create, establish: @establish.attributes
    end

    assert_redirected_to establish_path(assigns(:establish))
  end

  test "should show establish" do
    get :show, id: @establish.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @establish.to_param
    assert_response :success
  end

  test "should update establish" do
    put :update, id: @establish.to_param, establish: @establish.attributes
    assert_redirected_to establish_path(assigns(:establish))
  end

  test "should destroy establish" do
    assert_difference('Establish.count', -1) do
      delete :destroy, id: @establish.to_param
    end

    assert_redirected_to establishes_path
  end
end
