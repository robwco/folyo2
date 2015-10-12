class DailyLeadsJob
	def perform
		return if Time.now.saturday? || Time.now.sunday?

		User.active.each do |user|
			WorkerMailer.delay.daily_leads(user)
		end
	end
end
