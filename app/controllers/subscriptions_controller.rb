class SubscriptionsController < ApplicationController
	before_filter :load_plans
	before_filter :authenticate_user!, only: [:welcome, :edit, :update, :upgrade_yearly, :upgrade_plan]

  def welcome
	
  end

  def new
	@user = User.new
	@user.subscription = Subscription.new
	@coupon = params[:coupon]
  end

  def edit
  end

  def create
	@user = User.new(sign_up_params)

	if CreateSubscription.call(@plan, @user, params[:stripeToken], params[:coupon_code])
		sign_in('user', @user)
		redirect_to welcome_path	
	else
		render :new
	end
  end

  def update

  end

  def upgrade_yearly
	redirect_to edit_user_registration_path unless @yearly_plan
  end

  def upgrade_plan
	redirect_to edit_user_registration_path unless current_user.subscription.plan.monthly?

	if ChangePlan.call(current_user.subscription, @yearly_plan)
		redirect_to edit_user_registration_path
	else
		flash[:notice] = 'There was an error upgrading your subscription. Please try again later.'
		render 'upgrade_yearly'
	end
  end

  def cancel
	@cancellation = Cancellation.new	
  end

  def cancel_post
	case params[:cancel_reason]
	when Cancellation::NOT_ENOUGH_RESPONSES.to_s
		render :not_enough_responses
	when Cancellation::WRONG_LEAD_TYPES.to_s
		@cancellation = Cancellation.new	
		render :wrong_lead_types
	when Cancellation::HIGHER_QUALITY_LEADS.to_s
		render :higher_quality_leads
	when Cancellation::IM_BOOKED.to_s
		render :im_booked
	else
		@cancellation = Cancellation.new	
		render 'cancel'
	end

  end

  def cancel_leads_followup
	  @cancellation = Cancellation.new params[:cancellation]

	  if @cancellation.valid?
		WorkerMailer.requested_leads(current_user, @cancellation.requested_leads).deliver
	  else
		render 'cancel'
	  end
  end

  def destroy
	  if CancelSubscription.call(current_user)
		  flash[:notice] = 'Your Workshop subscription will end at the end of your current billing period.'
		  redirect_to edit_user_registration_path
	  else
		  flash[:notice] = 'There was an error canceling your account. Please try again or contact Customer Service if you are unable to cancel.'
		  redirect_to cancel_subscription_path
	  end
  end

  def reactivate
	if ReactivateSubscription.call(current_user, current_user.subscription)
	  flash[:notice] = 'Your Workshop subscription was reactivated!'
	else
	  flash[:notice] = 'There was an error reactivating your account. Please try again or contact Customer Service if you are unable to reactivate your account.'
	end

	redirect_to edit_user_registration_path
  end

  private

	  def sign_up_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation, {:category_ids => []})
	  end

	  def load_plans
		@plan = Plan.where(published: true, interval: 'month').first
		@yearly_plan = Plan.where(published: true, interval: 'year').first
	  end
end
