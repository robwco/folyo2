class Lead < ActiveRecord::Base
	validates_presence_of :title, :url, :name, :email
	belongs_to :category

	has_many :favorite_leads
	has_many :favorited_by, through: :favorite_leads, source: :user
	  
	scope :most_recent, -> { order("leads.created_at desc")}
	scope :most_recently_updated, -> { order("leads.updated_at desc")}
	scope :today, -> { where(:created_at => ((Time.now - 24.hours)..Time.now)) }
	scope :this_week, -> { where(:created_at => ((Time.now - 7.days)..Time.now)) }
	scope :this_month, -> { where(:created_at => ((Time.now - 30.days)..Time.now)) }
	scope :recent_onboard, -> { where(:created_at => ((Time.now - 3.days)..Time.now)) }
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "40x40>" }, :default_url => "/images/:style/missing.png"
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
	scope :design, -> { where("category ilike '%DESIGN%' OR category ilike '10' OR category ilike '%MARKETING%' OR category ilike '%INTERACTION%' ") }
	scope :development, -> { where("category like '%DEVELOPMENT%'") }
	scope :rails, -> { where("category ilike '%RAILS%' OR category ilike '%RUBY%' OR title ilike '%RAILS%' OR title ilike '%RUBY%'") }
	scope :drupal, -> { where("category ilike '%DRUPAL%' OR title ilike '%DRUPAL%'") }
	scope :ecommerce, -> { where("category ilike '%SHOPIFY%' OR category ilike '%MAGENTO%' OR category ilike '%STORE%' OR title ilike '%SHOPIFY%' OR title ilike '%MAGENTO%' OR title ilike '%STORE%' OR title ilike '%ECOMMERCE%' OR category ilike '%ECOMMERCE%'") }
	scope :logo, -> { where("category ilike '%LOGO%' OR category ilike '%BRAND%' OR category ilike '%BRANDING%' OR title ilike '%LOGO%' OR title ilike '%BRAND%' OR title ilike '%BRANDING%' OR title ilike '%IDENTITY%'") }

	scope :keyword, -> (keyword) { where("leads.title ILIKE ? OR leads.description ILIKE ? OR leads.name ILIKE ? OR leads.email ILIKE ?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%") unless keyword.blank? }
	scope :with_category, -> (category_ids) { where("category_id in (?)", category_ids) unless category_ids.blank? }
	scope :after, -> (after_date) { where("created_at >= ?", after_date) unless after_date.blank? }
	
  def category_name
         category.name unless category.blank?
  end
end
