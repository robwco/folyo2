class Lead < ActiveRecord::Base
	validates_presence_of :title, :url, :name, :email, :category
	scope :most_recent, -> { order("created_at desc")}
	scope :most_recently_updated, -> { order("updated_at desc")}
	scope :today, -> { where(:created_at => ((Time.now - 24.hours)..Time.now)) }
	scope :this_week, -> { where(:created_at => ((Time.now - 7.days)..Time.now)) }
	scope :this_month, -> { where(:created_at => ((Time.now - 30.days)..Time.now)) }
	scope :recent_onboard, -> { where(:created_at => ((Time.now - 3.days)..Time.now)) }
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "40x40>" }, :default_url => "/images/:style/missing.png"
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
	scope :design, -> { where("category like '%DESIGN%'") }
	scope :development, -> { where("category like '%DEVELOPMENT%'") }
end
