class Project < ActiveRecord::Base
  enum status: [:seeking_freelancer, :accepted, :complete]
  def self.status_with_label
    [["Seeking freelancers", :seeking_freelancer], ["Accepted, in progress", :accepted], ["Completed", :complete]]
  end

	belongs_to :user
	belongs_to :listing_package
	has_many :replies
	has_many :messages
  has_and_belongs_to_many :categories

	before_save :add_protocol_to_website

	#company profile step
	has_attached_file :company_logo, :styles => { :medium => "190x190>", :thumb => "190x190>" }, default_url: 'company.png'
	validates_attachment_content_type :company_logo, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	validates :organization, presence: { message: "Your organization name is required." }
	validates :website, presence: { message: "Your website is required." }
	validates :company_description, presence: { message: "Your description is required." }

	validates :title, presence: { message: "'What kind of help do you need?' is required." }
	validates :budget, presence: { message: "'What type of budget do you have for this project?' is required." }

	scope :published, -> { where(published: true) }
	scope :drafted, -> { where(published: false) }
	scope :recent, -> (limit_to = nil) { order(created_at: :desc).limit(limit_to ? limit_to : 5) }
	scope :owned_by, -> (user) { where(user_id: user.id) }
	scope :in_conversation, -> (user) { joins(replies: :messages).where("replies.user_id = ?", user.id).distinct }
	scope :replied_by, -> (user) { joins(:replies).where("replies.user_id = ?", user.id).distinct }

  self.per_page = 5  

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

  def read_messages(user)
    self.messages.sent_to(user).update_all(message_read: true)
  end

private
	def add_protocol_to_website
		if self.website
			self.website = "http://#{self.website}" unless self.website.start_with? "http"
		end
	end
end
