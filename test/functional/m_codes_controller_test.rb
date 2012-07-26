require 'test_helper'

class MCodesControllerTest < ActionController::TestCase
  setup do
    @m_code = m_codes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:m_codes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create m_code" do
    assert_difference('MCode.count') do
      post :create, m_code: @m_code.attributes
    end

    assert_redirected_to m_code_path(assigns(:m_code))
  end

  test "should show m_code" do
    get :show, id: @m_code.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @m_code.to_param
    assert_response :success
  end

  test "should update m_code" do
    put :update, id: @m_code.to_param, m_code: @m_code.attributes
    assert_redirected_to m_code_path(assigns(:m_code))
  end

  test "should destroy m_code" do
    assert_difference('MCode.count', -1) do
      delete :destroy, id: @m_code.to_param
    end

    assert_redirected_to m_codes_path
  end
end
