class Project < ActiveRecord::Base

	belongs_to :user
	belongs_to :listing_package
	has_many :replies

	before_save :add_protocol_to_website

	#company profile step
	has_attached_file :company_logo, :styles => { :medium => "190x190>", :thumb => "190x190>" }, default_url: 'company.png'
	validates_attachment_content_type :company_logo, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	validates :organization, presence: { message: "Your organization name is required." }, if: :company_profile_or_published?
	validates :website, presence: { message: "Your website is required." }, if: :company_profile_or_published?
	validates :company_description, presence: { message: "Your description is required." }, if: :company_profile_or_published?

	#project brief step
	has_attached_file :photo, :styles => { :medium => "190x190>", :thumb => "190x190>" }
	validates_attachment_content_type :photo, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	validates :title, presence: { message: "'What kind of help do you need?' is required." }, if: :project_brief_or_published?
	validates :goals, presence: { message: "'What are you trying to accomplish?' is required." }, if: :project_brief_or_published?
	validates :examples, presence: { message: "'What are some examples (logos, sites, apps, etc.) that you like?' is required." }, if: :project_brief_or_published?
	validates :deadline, presence: { message: "'What is the target deadline and why?' is required." }, if: :project_brief_or_published?
	#validates :budget, presence: { message: "'What type of budget do you have for this project?' is required." }, if: :project_brief_or_published?
	#validates :deliverables, presence: { message: "'What kind of deliverables do you expect?' is required." }, if: :project_brief_or_published?
	#validates :name, presence: { message: "Your name is required." }, if: :project_brief_or_published?
	#validates :email, presence: { message: "Your email is required." }, if: :project_brief_or_published?

	scope :published, -> { where(published: true) }
	scope :drafted, -> { where(published: false) }
	scope :recent, -> (limit_to = nil) { order(created_at: :desc).limit(limit_to ? limit_to : 5) }
	scope :owned_by, -> (user) { where(user_id: user.id) }
	scope :in_conversation, -> (user) { joins(replies: :messages).where("replies.user_id = ?", user.id).distinct }
	scope :replied_by, -> (user) { joins(:replies).where("replies.user_id = ?", user.id).distinct }

	def reply_from(user)
		return nil if user.nil?
		self.replies.where(user_id: user.id).first
	end

	def reply_from?(user)
		return nil if user.nil?
		self.reply_from(user).present?
	end

	def publish
		self.published = true
		save
	end

	def allow_replies_from?(user)
    return true if user.blank?
		self.user != user
	end

	def allow_portfolio_replies?
		self.listing_package.allow_portfolio_replies? if self.listing_package
	end

	def company_profile_or_published?
		self.status == "company_profile" || published?
	end

	def project_brief_or_published?
		self.status == "project_brief" || published?
	end

private
	def add_protocol_to_website
		if self.website
			self.website = "http://#{self.website}" unless self.website.start_with? "http"
		end
	end
end
