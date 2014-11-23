class Exclusive < ActiveRecord::Base
	validates_presence_of :title, :url, :name, :email
	scope :most_recent, -> { order("created_at desc").limit(50) }
	scope :today, -> { where(:created_at => ((Time.now - 20.hours)..Time.now)) }
	has_attached_file :pic, :styles => { :medium => "300x300>", :thumb => "100x100>" }
	validates_attachment_content_type :pic, :content_type => ["image/jpg", "image/jpeg", "image/png"]
end
