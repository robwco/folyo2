class Reply < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  has_many :messages

  has_attached_file :portfolio_image, :styles => { :medium => "800x600>", :thumb => "200x150>" }
  validates_attachment_content_type :portfolio_image, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  scope :published, -> { where(published: true) }
  scope :replied_to, -> (user) { joins(:project).published.where(projects: { user_id: user.id }).order(created_at: :desc) }
  scope :replies_from, -> (user) { published.where(user_id: user.id) }

  def publish
	self.publised = true
	self.published_at = Time.now
	save
  end
end
