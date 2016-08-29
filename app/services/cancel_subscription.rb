class CancelSubscription
  def self.call(user)
    begin
      stripe_sub = nil

      return false if user.stripe_customer_id.blank?

      customer = Stripe::Customer.retrieve(user.stripe_customer_id)

      return false if customer.subscriptions.count == 0

      stripe_sub = customer.subscriptions.retrieve(user.subscription.stripe_id)
      stripe_sub.delete(at_period_end: true)

      user.canceling = true
      user.save!
    rescue Stripe::StripeError => e
      user.errors[:base] << e.message
	  return false
    end

    return true
  end 
end
