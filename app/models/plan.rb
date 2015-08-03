class Plan < ActiveRecord::Base
	has_paper_trail
	validates :stripe_id, uniqueness: true, presence: { message: 'ID cannot be blank' }
	validates :amount, presence: { message: '/ Price cannot be blank' }
	validates :name, presence: true

	scope :active, -> { where(:published => true) }

	def price
		(amount / 100).round
	end

	def monthly?
		interval == 'month'
	end

	def yearly?
		interval == 'year'
	end

	def has_trial?
		trial_period_days > 0
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
		@published = false
		save
	end
end
