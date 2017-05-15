class PlansController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_site_owner
  before_action :set_plan, only: [:edit, :update]

  def index
	  @plans = Plan.all
  end

  def new
	  @plan = Plan.new
	  @plan.interval_count = 1
  end

  def edit
  end

  def create
	 @plan = CreatePlan.call(plan_params) 
	 if @plan.errors.empty?
		 redirect_to plans_path
	 else
		 render :new
	 end
  end

  def update
    respond_to do |format|
		if @plan.update(plan_params)
			format.html { redirect_to plans_path, notice: 'Plan details were udpated.' }
		else
			format.html { render :edit, notice: "Please correct the errors below." }
		end
	end

  end

  def archive
	@plan = Plan.find(params[:id])
	unless @plan.archive
		flash[:notice] = 'An error occurred when archiving the plan'
	end
	redirect_to plans_path

  end

  private
    def set_plan
      @plan = Plan.find(params[:id])
    end

    def plan_params
      params.require(:plan).permit(:stripe_id, :name, :description, :amount, :interval_count, :interval, :trial_period_days,
								  :offer_description, :leads, :portfolio_replies, :unlimited_replies, :view_reply_count )
    end

	def ensure_site_owner
	  redirect_to admin_root_path unless current_admin.site_owner?
	end
end
