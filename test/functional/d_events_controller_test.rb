require 'test_helper'

class DEventsControllerTest < ActionController::TestCase
  setup do
    @d_event = d_events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:d_events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create d_event" do
    assert_difference('DEvent.count') do
      post :create, d_event: @d_event.attributes
    end

    assert_redirected_to d_event_path(assigns(:d_event))
  end

  test "should show d_event" do
    get :show, id: @d_event.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @d_event.to_param
    assert_response :success
  end

  test "should update d_event" do
    put :update, id: @d_event.to_param, d_event: @d_event.attributes
    assert_redirected_to d_event_path(assigns(:d_event))
  end

  test "should destroy d_event" do
    assert_difference('DEvent.count', -1) do
      delete :destroy, id: @d_event.to_param
    end

    assert_redirected_to d_events_path
  end
end
