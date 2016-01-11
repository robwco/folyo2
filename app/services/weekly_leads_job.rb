class WeeklyLeadsJob
	def perform
		return unless Time.now.monday?

		User.active.each do |user|
			WorkerMailer.delay.weekly_leads(user)
		end
	end
end
