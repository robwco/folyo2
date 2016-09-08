class Reply < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  has_many :messages

  has_attached_file :portfolio_image, :styles => { :medium => "800x600>", :thumb => "200x150>" }
  validates_attachment_content_type :portfolio_image, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  validates :biography, presence: { message: "Enter your name" }, length: { maximum: 220 }
  validates :message, presence: { message: "Enter your name" }, length: { maximum: 220 }
  validates :next_steps, presence: { message: "Enter your name" }, length: { maximum: 220 }
  validates :portfolio_message, length: { maximum: 330 }

  scope :published, -> { where(published: true) }
  scope :replied_to, -> (user) { joins(:project).published.where(projects: { user_id: user.id }).order(created_at: :desc) }
  scope :replies_from, -> (user) { published.where(user_id: user.id) }
  scope :read, -> { where(message_read: true) }
  scope :unread, -> { where(message_read: false) }
  scope :unarchived, -> { where(archived: false) }

  def visible_to?(user)
    self.owned_by?(user) || (self.project && self.project.owned_by?(user))
  end

  def publish
    self.published = true
    self.published_at = Time.now
    save
  end

  def archive
    self.archived = true
    save
  end

  def unread?
    !self.message_read
  end

  def mark_read(user)
    if self.project && self.project.owned_by?(user)
      self.message_read = true
      self.save
    end
    self.messages.sent_to(user).update_all(message_read: true)
  end

  def owned_by?(check_user)
    self.user == check_user
  end

end
