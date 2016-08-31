class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :reply
  belongs_to :project

  validates :message, presence: { message: "Message text is required." }

  scope :owned_by, -> (user) { where(user_id: user.id).order(created_at: :desc) }
  scope :sent_to, -> (user) { where(to_user_id: user.id).order(created_at: :desc) }
  scope :unread, -> { where(message_read: false) }
  scope :read, -> { where(message_read: true) }
  scope :unarchived, -> { where(archived: false) }
  scope :visible_to, -> (user) { where("user_id = ? OR to_user_id = ?", user.id, user.id).order(created_at: :desc) }

  def unread?
    !self.message_read
  end

  def sent_to?(check_user)
    self.to_user_id == check_user.id
  end

  def owned_by?(check_user)
    self.user == check_user
  end

  def archive
    self.archived = true
    self.message_read= true
    save
  end
end
