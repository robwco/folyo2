require 'test_helper'

class RecommendedFreelancersControllerTest < ActionController::TestCase
  setup do
    @recommended_freelancer = recommended_freelancers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recommended_freelancers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recommended_freelancer" do
    assert_difference('RecommendedFreelancer.count') do
      post :create, recommended_freelancer: { description: @recommended_freelancer.description, email: @recommended_freelancer.email, name: @recommended_freelancer.name, price: @recommended_freelancer.price, title: @recommended_freelancer.title }
    end

    assert_redirected_to recommended_freelancer_path(assigns(:recommended_freelancer))
  end

  test "should show recommended_freelancer" do
    get :show, id: @recommended_freelancer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @recommended_freelancer
    assert_response :success
  end

  test "should update recommended_freelancer" do
    patch :update, id: @recommended_freelancer, recommended_freelancer: { description: @recommended_freelancer.description, email: @recommended_freelancer.email, name: @recommended_freelancer.name, price: @recommended_freelancer.price, title: @recommended_freelancer.title }
    assert_redirected_to recommended_freelancer_path(assigns(:recommended_freelancer))
  end

  test "should destroy recommended_freelancer" do
    assert_difference('RecommendedFreelancer.count', -1) do
      delete :destroy, id: @recommended_freelancer
    end

    assert_redirected_to recommended_freelancers_path
  end
end
