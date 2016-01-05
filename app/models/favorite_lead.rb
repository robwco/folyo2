class FavoriteLead < ActiveRecord::Base
  belongs_to :lead
  belongs_to :user

  has_many :state, through: :user

end
