class WeeklyLeadsJob
  def perform
    return unless Time.now.tuesday?

    User.active.each do |user|
      WorkerMailer.delay.weekly_leads(user) if user.favorite_leads.present?
    end
  end
end
