class Category < ActiveRecord::Base
  has_many :lead
  has_and_belongs_to_many :users

end
