module PlansHelper
	def plan_header(plan)
		return "<span class=\"pro\">#{plan.name}</span> $#{plan.price}/month".html_safe if plan.price > 0
		plan.name
	end
end
