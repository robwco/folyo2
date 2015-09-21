class RssLink < ActiveRecord::Base
  belongs_to :rss_feed

	scope :most_recent, -> { order("rss_links.pub_date desc")}
	scope :newest, -> { where(:pub_date => ((Time.now - 96.hours)..Time.now)) }
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

	def approve
		if ApprovedLink.create!({
			title: self.title,
			link: self.link,
			description: self.description,
			pub_date: self.pub_date,
			guid: self.guid
		})
			hide!
			return true
		else
			return false
		end
	end
end

