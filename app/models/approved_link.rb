class ApprovedLink < ActiveRecord::Base
	scope :most_recent, -> { order("approved_links.pub_date desc")}
	scope :visible, -> { where(:hidden => nil) }

	def hide
		self.hidden = true
	end

	def hide!
		hide
		save
	end

	def show
		self.hidden = nil
	end

	def show!
		show
		save
	end
end
