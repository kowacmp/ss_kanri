require 'test_helper'

class MAuthoritiesControllerTest < ActionController::TestCase
  setup do
    @m_authority = m_authorities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:m_authorities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create m_authority" do
    assert_difference('MAuthority.count') do
      post :create, m_authority: @m_authority.attributes
    end

    assert_redirected_to m_authority_path(assigns(:m_authority))
  end

  test "should show m_authority" do
    get :show, id: @m_authority.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @m_authority.to_param
    assert_response :success
  end

  test "should update m_authority" do
    put :update, id: @m_authority.to_param, m_authority: @m_authority.attributes
    assert_redirected_to m_authority_path(assigns(:m_authority))
  end

  test "should destroy m_authority" do
    assert_difference('MAuthority.count', -1) do
      delete :destroy, id: @m_authority.to_param
    end

    assert_redirected_to m_authorities_path
  end
end
