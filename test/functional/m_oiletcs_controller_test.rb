require 'test_helper'

class MOiletcsControllerTest < ActionController::TestCase
  setup do
    @m_oiletc = m_oiletcs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:m_oiletcs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create m_oiletc" do
    assert_difference('MOiletc.count') do
      post :create, m_oiletc: @m_oiletc.attributes
    end

    assert_redirected_to m_oiletc_path(assigns(:m_oiletc))
  end

  test "should show m_oiletc" do
    get :show, id: @m_oiletc.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @m_oiletc.to_param
    assert_response :success
  end

  test "should update m_oiletc" do
    put :update, id: @m_oiletc.to_param, m_oiletc: @m_oiletc.attributes
    assert_redirected_to m_oiletc_path(assigns(:m_oiletc))
  end

  test "should destroy m_oiletc" do
    assert_difference('MOiletc.count', -1) do
      delete :destroy, id: @m_oiletc.to_param
    end

    assert_redirected_to m_oiletcs_path
  end
end
