class AdminsController < ApplicationController
	before_filter :authenticate_admin!
  

	def welcome
    @users = User.all
    @leads = Lead.all
    @categories = Category.all
    @plans = Plan.all
    @subscriptions = Subscription.all
	end

end
