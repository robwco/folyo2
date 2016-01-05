class FavoriteLead < ActiveRecord::Base
  belongs_to :lead
  belongs_to :user

  has_many :state, through: :user

  aasm column: 'state' do
		state :first_contact, initial: true
		state :follow_up
		state :touch_base
  end

  event :add_to_follow_up do
  	transitions :to => :follow_up, from [:any]
  end

  event :add_to_touch_base do
  	transitions :to => :touch_base, from [:any]
  end
end
