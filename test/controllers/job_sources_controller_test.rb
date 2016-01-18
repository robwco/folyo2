require 'test_helper'

class JobSourcesControllerTest < ActionController::TestCase
  setup do
    @job_source = job_sources(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:job_sources)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create job_source" do
    assert_difference('JobSource.count') do
      post :create, job_source: { name: @job_source.name, url: @job_source.url }
    end

    assert_redirected_to job_source_path(assigns(:job_source))
  end

  test "should show job_source" do
    get :show, id: @job_source
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @job_source
    assert_response :success
  end

  test "should update job_source" do
    patch :update, id: @job_source, job_source: { name: @job_source.name, url: @job_source.url }
    assert_redirected_to job_source_path(assigns(:job_source))
  end

  test "should destroy job_source" do
    assert_difference('JobSource.count', -1) do
      delete :destroy, id: @job_source
    end

    assert_redirected_to job_sources_path
  end
end
