class ReactivateSubscription
	def self.call(user, subscription)
		if ChangePlan.call(subscription, subscription.plan)
			user.canceling = false
			user.save!
			return true
		end

		false	
	end
end
