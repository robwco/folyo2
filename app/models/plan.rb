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
		return self.interval if self.interval_count.blank? || self.interval_count <= 1 

		"every #{self.interval_count} #{self.interval}s"
	end

	def archive
		self.published = false
		save
	end
end
