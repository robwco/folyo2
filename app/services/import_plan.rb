class ImportPlan
  def self.call(imported_plan)
	  options = Hash.new

	  options[:stripe_id] = imported_plan.slug
	  options[:name] = imported_plan.name
	  options[:description] = "Imported from Memberful, ID = #{imported_plan.memberful_id}"
	  options[:amount] = imported_plan.price
	  options[:interval] = imported_plan.interval_unit
	  options[:interval_count] = imported_plan.interval_count
	  options[:trial_period_days] = 0
	  options[:published] = false

	  plan = CreatePlan.call(options)

	  imported_plan.plan_id = plan.id
	  imported_plan.save!

	  return plan
  end
end
