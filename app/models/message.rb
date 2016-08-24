class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :reply
  belongs_to :project

  validates :message, presence: { message: "Message text is required." }

  scope :sent_to, -> (user) { where(to_user_id: user.id).order(created_at: :desc) }
  scope :unread, -> { where(message_read: false) }
  scope :read, -> { where(message_read: true) }
  scope :unarchived, -> { where(archived: false) }

  def unread?
    !self.message_read
  end

  def sent_to?(user)
    self.to_user_id == user.id
  end

  def archive
    self.archived = true
    self.message_read= true
    save
  end
end
