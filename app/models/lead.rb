class Lead < ActiveRecord::Base
	validates_presence_of :title, :url, :name, :email, :category
	scope :most_recent,-> { order("created_at desc").limit(50) }
	scope :today, -> { where(:created_at => (Time.now.beginning_of_day..Time.now)) }
end
