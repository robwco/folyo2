class Person < ActiveRecord::Base
	belongs_to :user
	scope :most_recently_updated, -> { order("updated_at desc")}
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"], :default_url => "/images/missing.png"
  
end