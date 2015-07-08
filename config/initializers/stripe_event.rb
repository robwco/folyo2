StripeEvent.event_retriever = lambda do |params|
  return nil if StripeWebhook.exists?(stripe_id: params[:id])
  #StripeWebhook.create!(stripe_id: params[:id])
  Stripe::Event.retrieve(params[:id])
end

StripeEvent.configure do |events|
  events.subscribe 'charge.succeeded' do |event|
	charge = event.data.object
	if charge.fee > 0
		user = User.with_stripe_id charge.customer

		unless user.blank?
			user.pay! if user.may_pay?
			user.reactivate! if user.may_reactivate?
		end
	end
  end

  events.subscribe 'charge.failed' do |event|
	charge = event.data.object

	user = User.with_stripe_id charge.customer
	unless user.blank?
		user.overdue! if user.may_overdue?
	end
  end

  events.subscribe 'customer.subscription.updated' do |event|
	subscription = event.data.object

	user = User.with_stripe_id subscription.customer

	unless user.blank?
		user.subscription.update_billing_period subscription
		user.subscription.save!
	end
  end

  events.subscribe 'customer.subscription.deleted' do |event|
	subscription = event.data.object

	user = User.with_stripe_id subscription.customer
	unless user.blank?
		user.cancel! if user.may_cancel?
	end
  end
end
