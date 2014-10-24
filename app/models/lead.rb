class Lead < ActiveRecord::Base
	validates_presence_of :title, :url, :name, :email, :category
	scope :most_recent,-> { order("created_at desc").limit(10) }
end
