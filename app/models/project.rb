class Project < ActiveRecord::Base

	belongs_to :user
	belongs_to :listing_package
	has_many :replies

	has_attached_file :company_logo, :styles => { :medium => "190x190>", :thumb => "190x190>" }
	has_attached_file :photo, :styles => { :medium => "190x190>", :thumb => "190x190>" }

	validates :title, presence: { message: "'What kind of help do you need?' is required." }
	validates :goals, presence: { message: "'What are you trying to accomplish?' is required." }
	validates :examples, presence: { message: "'What are some examples (logos, sites, apps, etc.) that you like?' is required." }
	validates :deadline, presence: { message: "'What is the target deadline and why?' is required." }
	validates :budget, presence: { message: "'What type of budget do you have for this project?' is required." }
	validates :deliverables, presence: { message: "'What kind of deliverables do you expect?' is required." }
	validates :name, presence: { message: "Your name is required." }
	validates :email, presence: { message: "Your email is required." }
	validates :organization, presence: { message: "Your organization name is required." }
	validates :website, presence: { message: "Your website is required." }

	scope :recent, -> (limit_to = nil) { all.order(created_at: :desc).limit(limit_to ? limit_to : 5) }
	scope :owned_by, -> (user) { where(user_id: user.id) }
	scope :in_conversation, -> (user) { joins(replies: :messages).where("replies.user_id = ?", user.id).distinct }
	scope :replied_by, -> (user) { joins(:replies).where("replies.user_id = ?", user.id).distinct }

	def reply_from(user)
		self.replies.where(user_id: user.id).first
	end

	def reply_from?(user)
		self.reply_from(user).present?
	end
end
