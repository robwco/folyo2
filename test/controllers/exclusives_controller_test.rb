require 'test_helper'

class ExclusivesControllerTest < ActionController::TestCase
  setup do
    @exclusive = exclusives(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:exclusives)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create exclusive" do
    assert_difference('Exclusive.count') do
      post :create, exclusive: { budget: @exclusive.budget, description: @exclusive.description, email: @exclusive.email, linkedin: @exclusive.linkedin, name: @exclusive.name, notes: @exclusive.notes, title: @exclusive.title, twitter: @exclusive.twitter, type: @exclusive.type, url: @exclusive.url, website: @exclusive.website }
    end

    assert_redirected_to exclusive_path(assigns(:exclusive))
  end

  test "should show exclusive" do
    get :show, id: @exclusive
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @exclusive
    assert_response :success
  end

  test "should update exclusive" do
    patch :update, id: @exclusive, exclusive: { budget: @exclusive.budget, description: @exclusive.description, email: @exclusive.email, linkedin: @exclusive.linkedin, name: @exclusive.name, notes: @exclusive.notes, title: @exclusive.title, twitter: @exclusive.twitter, type: @exclusive.type, url: @exclusive.url, website: @exclusive.website }
    assert_redirected_to exclusive_path(assigns(:exclusive))
  end

  test "should destroy exclusive" do
    assert_difference('Exclusive.count', -1) do
      delete :destroy, id: @exclusive
    end

    assert_redirected_to exclusives_path
  end
end
