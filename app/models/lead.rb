class Lead < ActiveRecord::Base
	validates_presence_of :title, :url, :name, :email
	belongs_to :category
	
	scope :most_recent, -> { order("leads.created_at desc")}
	scope :most_recently_updated, -> { order("leads.updated_at desc")}
	scope :today, -> { where(:created_at => ((Time.now - 24.hours)..Time.now)) }
	scope :this_week, -> { where(:created_at => ((Time.now - 7.days)..Time.now)) }
	scope :this_month, -> { where(:created_at => ((Time.now - 30.days)..Time.now)) }
	scope :recent_onboard, -> { where(:created_at => ((Time.now - 3.days)..Time.now)) }
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "40x40>" }, :default_url => "/images/:style/missing.png"
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
	scope :design, -> { where("category like '%DESIGN%'") }
	scope :development, -> { where("category like '%DEVELOPMENT%'") }
	scope :rails, -> { where("category ilike '%RAILS%' OR category ilike '%RUBY%' OR title ilike '%RAILS%' OR title ilike '%RUBY%'") }
	scope :drupal, -> { where("category ilike '%DRUPAL%' OR title ilike '%DRUPAL%'") }
	scope :ecommerce, -> { where("category ilike '%SHOPIFY%' OR category ilike '%MAGENTO%' OR category ilike '%STORE%' OR title ilike '%SHOPIFY%' OR title ilike '%MAGENTO%' OR title ilike '%STORE%' OR title ilike '%ECOMMERCE%' OR category ilike '%ECOMMERCE%'") }
	scope :logo, -> { where("category ilike '%LOGO%' OR category ilike '%BRAND%' OR category ilike '%BRANDING%' OR title ilike '%LOGO%' OR title ilike '%BRAND%' OR title ilike '%BRANDING%' OR title ilike '%IDENTITY%'") }

	def category_name
		category.name
	end
end
