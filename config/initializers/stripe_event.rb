StripeEvent.event_retriever = lambda do |params|
  return nil if StripeWebhook.exists?(stripe_id: params[:id])
  StripeWebhook.create!(stripe_id: params[:id])
  Stripe::Event.retrieve(params[:id])
end

StripeEvent.configure do |events|
  events.subscribe 'charge.succeeded' do |event|
	charge = event.data.object
	return unless charge.fee > 0

	user = User.with_stripe_id charge.customer
	user.pay! if user.may_pay?
	user.reactivate! if user.may_reactivate?
  end

  events.subscribe 'charge.failed' do |event|
	charge = event.data.object

	user = User.with_stripe_id charge.customer
	user.overdue! if user.may_overdue?
  end

  events.subscribe 'customer.subscription.deleted' do |event|
	subscription = event.data.object

	user = User.with_stripe_id subscription.customer
	user.cancel! if user.may_cancel?
  end
end
