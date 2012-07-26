require 'test_helper'

class DCommentsControllerTest < ActionController::TestCase
  setup do
    @d_comment = d_comments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:d_comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create d_comment" do
    assert_difference('DComment.count') do
      post :create, d_comment: @d_comment.attributes
    end

    assert_redirected_to d_comment_path(assigns(:d_comment))
  end

  test "should show d_comment" do
    get :show, id: @d_comment.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @d_comment.to_param
    assert_response :success
  end

  test "should update d_comment" do
    put :update, id: @d_comment.to_param, d_comment: @d_comment.attributes
    assert_redirected_to d_comment_path(assigns(:d_comment))
  end

  test "should destroy d_comment" do
    assert_difference('DComment.count', -1) do
      delete :destroy, id: @d_comment.to_param
    end

    assert_redirected_to d_comments_path
  end
end
