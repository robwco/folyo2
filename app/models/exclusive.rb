class Exclusive < ActiveRecord::Base
	validates_presence_of :title, :url, :name, :email
	scope :most_recent, -> { order("created_at desc").limit(50) }
	scope :today, -> { where(:created_at => ((Time.now - 20.hours)..Time.now)) }
end
