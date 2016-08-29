class SubscriptionsController < ApplicationController
	before_filter :authenticate_user!, except: [:new, :create]

	def new_account_type
	  
	end

	def update_account_type
    if current_user.update_account_type(params[:type])
      if params[:type] == "freelancer"
        redirect_to freelancer_details_path
      else
        redirect_to client_details_path
      end
    else
      render :new_account_type
    end
	end
	
	def freelancer
    @user = current_user
    @selected_categories = Category.find(current_user.category_ids)
	end

  def update_freelancer
    @user = current_user
    if @user.update(freelancer_details_params)
      if session[:unsent_reply_biography]
        redirect_to complete_replies_path
      else
        redirect_to home_projects_path
      end
    else
      @selected_categories = Category.find(@user.category_ids)
      render :freelancer
    end
  end

  def client
    @user = current_user
  end

  def update_client
    @user = current_user
    if @user.update(client_details_params)
        redirect_to new_project_path
    else
      render :client
    end
  end

#	def new_finish_reply
#	
#	end
#	
#  def welcome 
#  	@user = current_user
#		@leads = Lead.all
#  end
#
#
#  def welcome_next_step
#    flash[:notice] = "Your credit card was successfully charged $#{current_user.subscription.plan.price}, and you are ready to go!"
#		@user = current_user
#		@leads = Lead.all
#  end
#
#  def choose
#    render layout: "folyo"
#  end

  #used
  def new
    #session[:last_page] = request.env['HTTP_REFERER'] || home_projects_url

    @user = User.new

    if params[:plan]
      begin
        @plan = Plan.active.find(params[:plan]) 
      rescue 
        flash[:error] = "That plan doesn't exist."
        redirect_to(root_path) and return
      end
    else
      @plan = Plan.active.where(amount: 0).first
    end

    @yearly = Plan.active.where(interval: 'year').first

    @user.subscription = Subscription.new
    @coupon = params[:coupon]
  end

  def create
	  #render plain: params.inspect and return
    @user = User.new(sign_up_params)
    @plan = Plan.active.find(params[:plan])

    redirect_to '/' if @plan.blank?

    if CreateSubscription.call(@plan, @user, params[:stripeToken], params[:coupon_code])
      sign_in('user', @user)
      if @user.account_type.blank?
        redirect_to account_type_path
      else
        redirect_to freelancer_details_path
      end
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

#  def categories
#    @selected_category = params[:category_id]
#    @user = current_user
#
#    unless @user.category_ids.include? @selected_category
#      @user.category_ids = @user.category_ids.push @selected_category
#      @user.save!
#    end
#  end
#
#  def categories_save
#    @user = current_user
#    
#    if @user.update update_categories_params
#      flash[:notice] = 'Your selected categories were updated!'
#      redirect_to edit_user_registration_path
#    else
#      render :categories
#    end
#  end

  def upgrade_plan
    @plan = Plan.active.where(portfolio_replies: true).first
    redirect_to edit_user_registration_path if @plan.blank?
  end

  def upgrade_save
    @plan = Plan.active.where(portfolio_replies: true).first

    redirect_to edit_user_registration_path if (@plan.blank? || current_user.subscription.allow_portfolio_replies?)

    if CreateSubscription.call(@plan, current_user, params[:stripeToken], nil)
      flash[:notice] = 'You can attach portfolio pieces to your replies now!'
      redirect_to edit_user_registration_path
    else
      flash[:error] = 'There was an error upgrading your subscription. Please try again later.'
      render 'upgrade_plan'
    end
  end

  def freelancer_upsell_save
    redirect_to edit_reply_path(reply_id: params[:reply_id]) if current_user.subscription.allow_portfolio_replies?

    @plan = Plan.active.where(portfolio_replies: true).first

    redirect_to edit_reply_path(reply_id: params[:reply_id]) if @plan.blank?

    if CreateSubscription.call(@plan, current_user, params[:stripeToken], nil)
      flash[:notice] = 'You can attach a portfolio to your reply now!'
      redirect_to edit_reply_path(reply_id: params[:reply_id])
    else
      flash[:notice] = 'There was an error upgrading your subscription. Please try again later.'
      @reply = Reply.find(params[:reply_id])
      render 'replies/preview'
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
		  flash[:notice] = 'Your Folyo subscription will end at the end of your current billing period.'
		  redirect_to edit_user_registration_path
	  else
		  flash[:notice] = 'There was an error canceling your account. Please try again or contact Customer Service if you are unable to cancel.'
		  redirect_to cancel_subscription_path
	  end
  end

  def reactivate
    if ReactivateSubscription.call(current_user, current_user.subscription)
      flash[:notice] = 'Your Folyo subscription was reactivated!'
    else
      flash[:notice] = 'There was an error reactivating your account. Please try again or contact Customer Service if you are unable to reactivate your account.'
    end

    redirect_to edit_user_registration_path
  end

  private

	  def sign_up_params
      params.require(:user).permit(:name, :email, :password, :account_type, :biography, :photo)
	  end

	  def freelancer_details_params
      params.require(:user).permit(:biography, :photo, :location, {:category_ids => []})
	  end

	  def client_details_params
      params.require(:user).permit(:company_logo, :company_name, :company_website, :company_biography, :photo)
	  end

	  def update_categories_params
      params.require(:user).permit({:category_ids => []})
	  end

	  def update_milestones_params
      params.require(:user).permit({:milestone_ids => []})
	  end
end
