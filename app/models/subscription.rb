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

  def allow_portfolio_replies?
	self.plan.allow_portfolio_replies? if self.plan
  end

  def allow_leads?
	self.plan.allow_leads? if self.plan
  end

  def allow_replies_to_projects?
	self.plan.allow_replies_to_projects? if self.plan
  end
end
