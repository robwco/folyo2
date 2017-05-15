require 'test_helper'

class RfpsControllerTest < ActionController::TestCase
  setup do
    @rfp = rfps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rfps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rfp" do
    assert_difference('Rfp.count') do
      post :create, rfp: { name: @rfp.name }
    end

    assert_redirected_to rfp_path(assigns(:rfp))
  end

  test "should show rfp" do
    get :show, id: @rfp
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rfp
    assert_response :success
  end

  test "should update rfp" do
    patch :update, id: @rfp, rfp: { name: @rfp.name }
    assert_redirected_to rfp_path(assigns(:rfp))
  end

  test "should destroy rfp" do
    assert_difference('Rfp.count', -1) do
      delete :destroy, id: @rfp
    end

    assert_redirected_to rfps_path
  end
end
