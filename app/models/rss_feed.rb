class RssFeed < ActiveRecord::Base
  has_many :rss_link

  def updated(last_updated)
	self.last_updated = last_updated
	save!
  end
end
