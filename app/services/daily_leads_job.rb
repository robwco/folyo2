class DailyLeadsJob
	def perform
		User.active.each do |user|
			WorkerMailer.delay.daily_leads(user)
		end
	end
end
