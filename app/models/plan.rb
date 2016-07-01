class Plan < ActiveRecord::Base
	has_paper_trail
	validates :stripe_id, uniqueness: true, presence: { message: 'ID cannot be blank' }
	validates :amount, presence: { message: '/ Price cannot be blank' }
	validates :name, presence: true

	scope :active, -> { where(:published => true) }
	scope :not_free, -> { where("amount > 0") }
	scope :monthly, -> { where(:published => true, :interval => 'month') }
	scope :annual, -> { where(:published => true, :interval => 'year') }

	def price
		(amount / 100).round
	end

	def annual_price
		return self.price if yearly?
		return ((12 / self.interval_count) * self.price).round if monthly?
		self.price
	end

	def monthly?
		interval == 'month'
	end

	def yearly?
		interval == 'year'
	end

	def has_trial?
		trial_period_days && trial_period_days > 0
	end

	def savings(plan)
		puts plan.annual_price
		puts self.annual_price
		0 if plan.nil?
		self.annual_price - plan.annual_price
	end

	def interval_text
		return " per #{interval}" if interval_count.blank? || interval_count <= 1 

		"every #{ActionController::Base.helpers.pluralize(interval_count, interval)}"
	end

	def next_billing_date
		return (interval_count.months).since(Time.now) if self.monthly?
		return (interval_count.years).since(Time.now) 
	end

	def archive
		self.published = false
		save
	end

	def allow_portfolio_replies?
		puts "HEREHERHER #{self.portfolio_replies?}"
		self.portfolio_replies?
	end

	def allow_leads?
		self.leads?
	end

	def allow_replies_to_projects?
		self.unlimited_replies?
	end
end
