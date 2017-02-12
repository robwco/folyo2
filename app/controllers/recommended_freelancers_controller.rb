class RecommendedFreelancersController < ApplicationController
  before_action :set_recommended_freelancer, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_admin!, except: [:show]

  respond_to :html

  def index
    @recommended_freelancers = RecommendedFreelancer.all
    respond_with(@recommended_freelancers)
  end

  def show
    respond_with(@recommended_freelancer)
  end

  def new
    @recommended_freelancer = RecommendedFreelancer.new
    respond_with(@recommended_freelancer)
  end

  def edit
  end

  def create
    @recommended_freelancer = RecommendedFreelancer.new(recommended_freelancer_params)
    @recommended_freelancer.save
    respond_with(@recommended_freelancer)
  end

  def update
    @recommended_freelancer.update(recommended_freelancer_params)
    respond_with(@recommended_freelancer)
  end

  def destroy
    @recommended_freelancer.destroy
    respond_with(@recommended_freelancer)
  end

  private
    def set_recommended_freelancer
      @recommended_freelancer = RecommendedFreelancer.find(params[:id])
    end

    def recommended_freelancer_params
      params.require(:recommended_freelancer).permit(:name, :type, :photo, :title, :description, :price, :email)
    end
end
