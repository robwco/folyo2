class WeeklyLeadsJob
	def perform
		return if Time.now.saturday? || Time.now.sunday? || Time.now.tuesday? || Time.now.wednesday? || Time.now.thursday? || Time.now.friday?

		User.active.each do |user|
			WorkerMailer.delay.weekly_leads(user)
		end
	end
end
