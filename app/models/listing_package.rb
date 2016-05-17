class ListingPackage < ActiveRecord::Base

	scope :active, -> { where(active: true) }

	def allow_portfolio_replies?
		self.unlimited_portfolio_replies?
	end

	def allow_sending_to_twitter?
		self.send_to_twitter?
	end

	def allow_sending_to_email_list?
		self.send_to_email_list?
	end
end
