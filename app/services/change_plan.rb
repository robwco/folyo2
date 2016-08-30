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

      subscription.update_billing_period stripe_sub
      subscription.plan = to_plan
      subscription.save!

      #custom_fields = Hash.new

      #custom_fields["workshop_plan"] = to_plan.stripe_id

      #Drip::Client.default_client.create_or_update_subscriber user.email, { 'custom_fields' => custom_fields }

    rescue Stripe::StripeError => e
      subscription.errors[:base] << e.message
      return false
    end

    subscription
  end
end
