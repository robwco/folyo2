class ProjectSale < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  belongs_to :listing_package
end
