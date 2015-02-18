class Rfp < ActiveRecord::Base
  validates :name, :presence => true
  has_attached_file :file
  validates_attachment_content_type :file, :content_type => ["application/pdf"]
end
