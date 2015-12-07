class FavoriteLead < ActiveRecord::Base
  belongs_to :lead
  belongs_to :user
end
