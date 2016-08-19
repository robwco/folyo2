class Reply < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  has_many :messages

  has_attached_file :portfolio_image, :styles => { :medium => "800x600>", :thumb => "200x150>" }
  validates_attachment_content_type :portfolio_image, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  validates :biography, presence: { message: "Enter your name" }, length: { maximum: 200 }
  validates :message, presence: { message: "Enter your name" }, length: { maximum: 200 }
  validates :next_steps, presence: { message: "Enter your name" }, length: { maximum: 200 }
  validates :portfolio_message, length: { maximum: 300 }

  scope :published, -> { where(published: true) }
  scope :replied_to, -> (user) { joins(:project).published.where(projects: { user_id: user.id }).order(created_at: :desc) }
  scope :replies_from, -> (user) { published.where(user_id: user.id) }
  scope :unread, -> { where(message_read: false) }
  scope :unarchived, -> { where(archived: false) }

  def publish
    self.published = true
    self.published_at = Time.now
    save
  end

  def archive
    self.archived = true
    save
  end
end
