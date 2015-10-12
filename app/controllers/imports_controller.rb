require 'memberful'

class ImportsController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_site_owner

  def plans
	  client = Memberful::Client.new
	  plans = client.plans.parsed_response
	  ImportedPlan.import(plans)

	  @plans = ImportedPlan.all
  end

  def import_plans
	  plans = ImportedPlan.where(plan_id: nil)

	  plans.each do |plan|
		  unless plan.plan.present?
			  #puts "Import plan #{plan.id}"
			  ImportPlan.call(plan)
		  end
	  end
	  
	  flash[:notice] = 'Your unimported Memberful plans were imported!'
	  redirect_to import_plans_path
  end

  def customers
	  client = Memberful::Client.new
	  @customers = Array.new

	  plans = ImportedPlan.all
	  plans.each do |plan|
		  (1..4).each do |page|
			  #puts "Plan #{plan.memberful_id} Page: #{page}"
			  subscribers = client.subscribers(plan.memberful_id, page)	
			  @customers.push subscribers
			  break if subscribers["subscriptions"].count < 20
		  end
	  end

	  @customers.each do |customer_plan|
		  ImportedSubscription.import(customer_plan["subscriptions"])
	  end

	  @customers = ImportedSubscription.all
  end

  def import_customers
	  subscriptions = ImportedSubscription.where(user_id: nil)

	  subscriptions.each do |subscription|
		  subscription.delay.import_subscription
	  end
	  
	  flash[:notice] = 'Your unimported Memberful customers are queued to import in the background!'
	  redirect_to import_customers_path
  end

  private
	def ensure_site_owner
	  redirect_to admin_root_path unless current_admin.site_owner?
	end
end
