class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :plan

  has_paper_trail

  def update_billing_period(billing_period)
	self.current_period_start = Time.at(billing_period.current_period_start).to_datetime
	self.current_period_end = Time.at(billing_period.current_period_end).to_datetime
  end

  def update_billing_period!(billing_period)
	  update_billing_period billing_period
	  save!
  end
end
