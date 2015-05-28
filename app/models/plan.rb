class Plan < ActiveRecord::Base
	has_paper_trail
	validates :stripe_id, uniqueness: true, presence: { message: 'ID cannot be blank' }
	validates :amount, presence: { message: '/ Price cannot be blank' }
	validates :name, presence: true

	def price
		(amount / 100).round
	end

	def monthly?
		interval == 'month'
	end

	def has_trial?
		trial_period_days > 0
	end
end
