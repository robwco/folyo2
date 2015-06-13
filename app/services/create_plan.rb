class CreatePlan
  def self.call(options={})
    plan = Plan.new(options)

    return plan unless plan.valid?

    begin
      Stripe::Plan.create(
        id: options[:stripe_id],
        amount: options[:amount],
        currency: 'usd',
        interval: options[:interval],
        interval_count: options[:interval_count],
        trial_period_days: options[:trial_period_days],
        name: options[:name],
      )
    rescue Stripe::StripeError => e
      plan.errors[:base] << e.message
      return plan
    end

	plan.published = true
	plan.save

    return plan
  end
end
