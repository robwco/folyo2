class SubscriptionsController < ApplicationController
	before_filter :load_plans
	before_filter :authenticate_user!, except: [:new, :create]

	def test_email
		category_ids = current_user.category_ids

		if category_ids.empty?
			@leads = Lead.eager_load(:category).most_recent.limit(4)
		else
			@leads = Lead.eager_load(:category).most_recent.where("category_id IN (?)", category_ids)
		end

		@exclusives = Exclusive.most_recent
		@categories = Category.all
		@milestones = Milestone.all
		@milestones_hash = Hash[ @milestones.map{ |m| [m.id, m.description] }]

		@user = current_user

		render 'worker_mailer/daily_leads', layout: false
		
	end

	def send_email
		WorkerMailer.delay.daily_leads(current_user)
		render plain: "Email delivered to #{current_user.email}"
	end

  def welcome 
    flash[:notice] = "Your credit card was successfully charged $#{current_user.subscription.plan.price}, and you are ready to go!"
		@user = current_user
		@leads = Lead.all
  end


  def welcome_next_step
    flash[:notice] = "Your credit card was successfully charged $#{current_user.subscription.plan.price}, and you are ready to go!"
		@user = current_user
		@leads = Lead.all
  end

  def new
	@user = User.new
	@plan = Plan.active.find(params[:plan])
	@yearly = Plan.active.where(interval: 'year').first

	redirect_to '/' if @plan.nil?

	@user.subscription = Subscription.new
	@coupon = params[:coupon]
  end

  def create
	@user = User.new(sign_up_params)
	@plan = Plan.active.find(params[:plan])

	redirect_to '/' if @plan.blank?

	if CreateSubscription.call(@plan, @user, params[:stripeToken], params[:coupon_code])
		sign_in('user', @user)
		redirect_to welcome_path	
	else
		render :new
	end
  end

  def update

  end

  def edit
  end

  def creditcard

  end

  def creditcard_save
		if ChangeSubscriptionCard.call(current_user.subscription, params[:stripeToken])
			flash[:notice] = 'Your credit card was updated!'
			redirect_to edit_user_registration_path
		else
			render :creditcard
		end

  end

  def categories
	@selected_category = params[:category_id]
	@user = current_user

	unless @user.category_ids.include? @selected_category
		@user.category_ids = @user.category_ids.push @selected_category
		@user.save!
	end
  end

  def categories_save
	@user = current_user
	
	if @user.update update_categories_params
		flash[:notice] = 'Your selected categories were updated!'
		redirect_to edit_user_registration_path
	else
		render :categories
	end
  end

  def milestones
	@selected_milestone = params[:milestone_id]
	@user = current_user
	unless @user.milestone_ids.include? @selected_milestone
		@user.milestone_ids = @user.milestone_ids.push @selected_milestone
		@user.save!
	end
  end

  def milestones_save
	@user = current_user
	
	if @user.update update_milestones_params
		flash[:notice] = 'Your milestones were updated!'
		redirect_to edit_user_registration_path
	else
		render :milestones
	end
  end

  def upgrade_plan
	@plans = Plan.active
	redirect_to edit_user_registration_path unless @plans.any?
  end

  def upgrade_save
	redirect_to edit_user_registration_path if current_user.subscription.plan.yearly?

	@plan = Plan.active.find(params[:plan])

	redirect_to edit_user_registration_path if @plan.blank?

	if ChangePlan.call(current_user.subscription, @plan)
		flash[:notice] = 'Your subscription was updated!'
		redirect_to edit_user_registration_path
	else
		flash[:notice] = 'There was an error upgrading your subscription. Please try again later.'
		render 'upgrade_plan'
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
		WorkerMailer.delay.requested_leads(current_user, @cancellation.requested_leads)
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

	  def update_categories_params
		params.require(:user).permit({:category_ids => []})
	  end

	  def update_milestones_params
		params.require(:user).permit({:milestone_ids => []})
	  end

	  def load_plans
	  end
end
