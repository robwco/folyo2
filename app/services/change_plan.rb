class ChangePlan
  def self.call(subscription, to_plan)
    from_plan = subscription.plan
    begin
      user = subscription.user

	  return false if user.stripe_customer_id.empty?
	  return false if subscription.stripe_id.empty?

      customer = Stripe::Customer.retrieve(user.stripe_customer_id)
      stripe_sub = customer.subscriptions.retrieve(subscription.stripe_id)

      stripe_sub.plan = to_plan.stripe_id
      stripe_sub.save
      subscription.plan = to_plan
      subscription.save!
    rescue Stripe::StripeError => e
      subscription.errors[:base] << e.message
	  return false
    end

    subscription
  end
end
