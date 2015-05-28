class PlansController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_site_owner

  def index
	  @plans = Plan.all
  end

  def new
	  @plan = Plan.new
  end

  def create
	 @plan = CreatePlan.call(plan_params) 
	 if @plan.errors.empty?
		 redirect_to plans_path
	 else
		 render :new
	 end
  end

  private
    def plan_params
      params.require(:plan).permit(:stripe_id, :name, :description, :amount, :interval, :trial_period_days)
    end

	def ensure_site_owner
	  redirect_to admin_root_path unless current_admin.site_owner?
	end
end
