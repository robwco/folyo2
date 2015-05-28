class ChangeSubscriptionCard
  def self.call(subscription, token)
    begin
      user = subscription.user
      customer = Stripe::Customer.retrieve(user.stripe_customer_id)

	  if customer.subscriptions.count == 0
		stripe_sub = customer.subscriptions.create(
			plan: subscription.plan.stripe_id,
			source: token
		)
		subscription.stripe_id = stripe_sub.id
		subscription.save
	  else
		stripe_sub = customer.subscriptions.retrieve(subscription.stripe_id)
		stripe_sub.source = token
		stripe_sub.save
	  end

	  user.reactivate! if user.may_reactivate?
    rescue Stripe::StripeError => e
      subscription.errors[:base] << e.message
	  return false
    end

    subscription
  end
end
