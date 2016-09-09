class Project < ActiveRecord::Base
  include AASM

	belongs_to :user
	belongs_to :listing_package
	has_many :replies, -> { order({has_portfolio: :desc}, :created_at) }
	has_many :messages
  has_and_belongs_to_many :categories

	before_save :parse_long_description

	validates :title, presence: { message: "'What kind of help do you need?' is required." }
	validates :budget, presence: { message: "'What type of budget do you have for this project?' is required." }

	scope :published, -> { where(published: true, archived: false) }
	scope :drafted, -> { where(published: false) }
	scope :recent, -> (limit_to = nil) { order(created_at: :desc).limit(limit_to ? limit_to : 10) }
	scope :owned_by, -> (user) { where(user_id: user.id) }
	scope :in_conversation, -> (user) { joins(replies: :messages).where("replies.user_id = ?", user.id).distinct }
	scope :replied_by, -> (user) { joins(:replies).where("replies.user_id = ?", user.id).distinct }

  self.per_page = 10

  aasm(:status) do
    state :seeking_freelancer, initial: true
    state :accepted
    state :completed

    event :seek do
      transitions from: [:accepted, :completed], to: :seeking_freelancer, after: :unarchive_project
    end
    event :accept do
      transitions from: [:seeking_freelancer, :completed], to: :accepted, after: :unarchive_project
    end
    event :complete do
      transitions from: [:seeking_freelancer, :accepted], to: :completed, after: :archive_project
    end
  end

  def self.statuses_with_labels
    [["Seeking freelancers", :seeking_freelancer], ["Accepted, in progress", :accepted], ["Completed", :completed]]
  end

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
    return false if self.archived
    return true if user.blank?
		self.user != user
	end

	def allow_portfolio_replies?
		self.listing_package.allow_portfolio_replies? if self.listing_package
	end

  def slug
    self.title.downcase.gsub(" ","-").gsub(/[._\/<>()'"]/,"")
  end

  def to_param
    "#{self.id}-#{self.slug}"
  end

  def pro?
    self.listing_package.present?
  end

  def owned_by?(check_user)
    self.user == check_user
  end
  
private
  def archive_project
    self.archived = true
  end
  def unarchive_project
    self.archived = false
  end
  def parse_long_description
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new,{})
    self.long_description_html = markdown.render(ERB::Util.html_escape(self.long_description))
  end
end
