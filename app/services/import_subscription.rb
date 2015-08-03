require 'securerandom'

class ImportSubscription
  def self.call(imported_subscription)
	  random_password = SecureRandom.hex

	  options = Hash.new
	  options[:name] = imported_subscription.name
	  options[:email] = imported_subscription.email
	  options[:stripe_customer_id] = imported_subscription.stripe_customer_id
	  options[:password] = random_password
	  options[:password_confirmation] = random_password

	  user = User.new(options)

	  imported_plan = ImportedPlan.includes(:plan).where(:memberful_id => imported_subscription.memberful_plan_id).first
	  return false if imported_plan.blank?

	  plan = imported_plan.plan

	  return false unless user.save

	  user.subscription = Subscription.new(
		  plan: plan,
		  user: user
	  )

      begin
		  stripe_sub = nil
		  
		  customer = Stripe::Customer.retrieve(user.stripe_customer_id)

		  card = customer.sources.first

		  unless card.nil?
			  user.last4 = card.last4
			  user.expiration_month = card.exp_month
			  user.expiration_year = card.exp_year
			  user.save
		  end

		  stripe_sub = customer.subscriptions.create(
			  plan: plan.stripe_id,
			  trial_end: imported_subscription.subscription_end.to_i
		  )

		  user.subscription.stripe_id = stripe_sub.id

		  user.subscription.current_period_start = imported_subscription.subscription_start
		  user.subscription.current_period_end = imported_subscription.subscription_end

		  user.subscription.save
		  user.save
      rescue Stripe::StripeError => e
		  user.destroy 
		  #puts e.message
		  return false
      end

	  imported_subscription.user_id = user.id
	  imported_subscription.save!

	  return user
  end
end
