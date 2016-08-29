class CreateSubscription
  def self.call(plan, user, token = nil, coupon_code = nil)
    if user.subscription.blank?
      user.subscription = Subscription.new(
        plan: plan,
        user: user
      )
      return false unless user.save
    else
      user.subscription.plan = plan
      return false unless user.subscription.save
    end

    if plan.amount.zero?
      user.subscribe
      user.save
      return true
    end

    coupon_code = nil if coupon_code.blank?
    customer_created = false

    begin
      stripe_sub = nil
      if user.stripe_customer_id.blank?
        customer_created = true
        customer = Stripe::Customer.create(
          source: token,
          email: user.email,
          description: user.name,
          plan: plan.stripe_id,
          coupon: coupon_code
        )
        user.stripe_customer_id = customer.id
        user.subscribe

        card = customer.sources.first
        user.last4 = card.last4
        user.expiration_month = card.exp_month
        user.expiration_year = card.exp_year

        user.save
        stripe_sub = customer.subscriptions.first
        user.subscription.coupon_code = coupon_code
      else
        customer = Stripe::Customer.retrieve(user.stripe_customer_id)
        stripe_sub = customer.subscriptions.create(
          plan: plan.stripe_id,
          coupon: user.subscription.coupon_code
        )
        user.reactivate! if user.may_reactivate?
      end

      user.subscription.stripe_id = stripe_sub.id
      user.subscription.update_billing_period stripe_sub

      user.subscription.save
    rescue Stripe::StripeError => e
      user.subscription.errors[:base] << e.message
      return false
    end

    #CreateOnboarding.call(user) if customer_created

    return true
  end 
end
