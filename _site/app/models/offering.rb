class Offering < ActiveRecord::Base
  has_attached_file :photo, :styles => { :medium => "190x190#", :thumb => "190x190#" }, default_url: 'company-logo-default.png'
  validates_attachment_content_type :photo, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  scope :this_month, -> { where(:created_at => ((Time.now - 30.days)..Time.now)) }
  scope :by_designers, -> { where(:category => "designer") }
  scope :by_developers, -> { where(:category => "developer") }
end
