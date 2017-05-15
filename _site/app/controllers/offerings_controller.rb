class OfferingsController < ApplicationController
  before_action :set_offering, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_admin!, except: [:show]

  respond_to :html

  def index
    @offerings = Offering.all
    respond_with(@offerings)
  end

  def show
    respond_with(@offering)
  end

  def new
    @offering = Offering.new
    respond_with(@offering)
  end

  def edit
  end

  def create
    @offering = Offering.new(offering_params)
    @offering.save
    respond_with(@offering)
  end

  def update
    @offering.update(offering_params)
    respond_with(@offering)
  end

  def destroy
    @offering.destroy
    respond_with(@offering)
  end

  private
    def set_offering
      @offering = Offering.find(params[:id])
    end

    def offering_params
      params.require(:offering).permit(:name, :email, :title, :description, :contact_info, :category, :photo)
    end
end
