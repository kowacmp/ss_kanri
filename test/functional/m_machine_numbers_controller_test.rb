require 'test_helper'

class MMachineNumbersControllerTest < ActionController::TestCase
  setup do
    @m_machine_number = m_machine_numbers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:m_machine_numbers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create m_machine_number" do
    assert_difference('MMachineNumber.count') do
      post :create, m_machine_number: @m_machine_number.attributes
    end

    assert_redirected_to m_machine_number_path(assigns(:m_machine_number))
  end

  test "should show m_machine_number" do
    get :show, id: @m_machine_number.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @m_machine_number.to_param
    assert_response :success
  end

  test "should update m_machine_number" do
    put :update, id: @m_machine_number.to_param, m_machine_number: @m_machine_number.attributes
    assert_redirected_to m_machine_number_path(assigns(:m_machine_number))
  end

  test "should destroy m_machine_number" do
    assert_difference('MMachineNumber.count', -1) do
      delete :destroy, id: @m_machine_number.to_param
    end

    assert_redirected_to m_machine_numbers_path
  end
end
