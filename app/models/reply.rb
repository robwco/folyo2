class Reply < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  has_many :messages

  has_attached_file :portfolio_image, :styles => { :medium => "800x600>", :thumb => "200x150>" }

  scope :published, -> { where(published: true) }
  scope :replied_to, -> (user) { joins(:project).published.where(projects: { user_id: user.id }).order(created_at: :desc) }
end
