class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :reply
  belongs_to :project

  validates :message, presence: { message: "Message text is required." }

  scope :sent_to, -> (user) { where(to_user_id: user.id).order(created_at: :desc) }
end
