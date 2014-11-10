class Lead < ActiveRecord::Base
	validates_presence_of :title, :url, :name, :email, :category
	scope :most_recent,-> { order("created_at desc").limit(50) }
	scope :today, -> { where(:created_at => (Time.now.beginning_of_day..Time.now)) }
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "40x40>" }, :default_url => "/images/:style/missing.png"
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
end
