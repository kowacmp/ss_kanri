require 'test_helper'

class DSaleReportsControllerTest < ActionController::TestCase
  setup do
    @d_sale_report = d_sale_reports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:d_sale_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create d_sale_report" do
    assert_difference('DSaleReport.count') do
      post :create, d_sale_report: @d_sale_report.attributes
    end

    assert_redirected_to d_sale_report_path(assigns(:d_sale_report))
  end

  test "should show d_sale_report" do
    get :show, id: @d_sale_report.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @d_sale_report.to_param
    assert_response :success
  end

  test "should update d_sale_report" do
    put :update, id: @d_sale_report.to_param, d_sale_report: @d_sale_report.attributes
    assert_redirected_to d_sale_report_path(assigns(:d_sale_report))
  end

  test "should destroy d_sale_report" do
    assert_difference('DSaleReport.count', -1) do
      delete :destroy, id: @d_sale_report.to_param
    end

    assert_redirected_to d_sale_reports_path
  end
end
