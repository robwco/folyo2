class CreatePlan
  def self.call(options={})
    plan = Plan.new(options)

    if !plan.valid?
      return plan
    end

    begin
      Stripe::Plan.create(
        id: options[:stripe_id],
        amount: options[:amount],
        currency: 'usd',
        interval: options[:interval],
        trial_period_days: options[:trial_period_days],
        name: options[:name],
      )
    rescue Stripe::StripeError => e
      plan.errors[:base] << e.message
      return plan
    end

	plan.published = true

	plans = Plan.all

	if plan.save
		Plan.where(published: true, interval: plan.interval).where.not(id: plan.id).update_all(published: false)
	end

    return plan
  end
end
