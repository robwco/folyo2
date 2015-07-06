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
		subscription.update_billing_period stripe_sub
		subscription.save
	  else
		stripe_sub = customer.subscriptions.retrieve(subscription.stripe_id)
		stripe_sub.source = token
		stripe_sub.save

		subscription.update_billing_period stripe_sub
		subscription.save
	  end

	  user.reactivate if user.may_reactivate?

      customer = Stripe::Customer.retrieve(user.stripe_customer_id)
	  card = customer.sources.first

	  user.update_card card
	  user.save!

    rescue Stripe::StripeError => e
      subscription.errors[:base] << e.message
	  return false
    end

    subscription
  end
end
