class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :reply
  belongs_to :project

  validates :message, presence: { message: "Message text is required." }
end
