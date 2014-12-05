class Exclusive < ActiveRecord::Base
	validates_presence_of :title, :name, :email, :description, :category, :pic
	scope :most_recent, -> { order("created_at desc") }
	scope :most_recently_updated, -> { order("updated_at desc")}
	scope :today, -> { where(:created_at => ((Time.now - 20.hours)..Time.now)) }
	scope :this_week, -> { where(:created_at => ((Time.now - 7.days)..Time.now)) }
	scope :recent_onboard, -> { where(:created_at => ((Time.now - 3.days)..Time.now)) }
	has_attached_file :pic, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
	validates_attachment_content_type :pic, :content_type => ["image/jpg", "image/jpeg", "image/png"]
end
