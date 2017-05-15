class ImportedPlan < ActiveRecord::Base
  belongs_to :plan

  def self.import(plans)
	plans.each do |plan|
		unless ImportedPlan.exists?(:memberful_id => plan["id"])
			imported_plan = ImportedPlan.new
			
			imported_plan.memberful_id = plan["id"]
			imported_plan.name = plan["name"]
			imported_plan.price = plan["price"]
			imported_plan.slug = plan["slug"]
			imported_plan.renewal_period = plan["renewal_period"]
			imported_plan.interval_unit = plan["interval_unit"]
			imported_plan.interval_count = plan["interval_count"]

			imported_plan.save!
		end
	end
  end
end
