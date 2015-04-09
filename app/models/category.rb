class Category < ActiveRecord::Base
  has_many :leads
end
