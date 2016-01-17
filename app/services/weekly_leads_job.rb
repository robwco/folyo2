class WeeklyLeadsJob
	def perform
		return unless Time.now.monday? && user.favorite_leads.present?

		User.active.each do |user|
			WorkerMailer.delay.weekly_leads(user)
		end
	end
end
