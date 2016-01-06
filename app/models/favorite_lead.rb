class FavoriteLead < ActiveRecord::Base
	include AASM
  belongs_to :lead
  belongs_to :user

  aasm column: 'state' do
		state :to_contact, initial: true
		state :attempting_to_reach
		state :in_conversation
		state :touching_base

	event :favorite do
      transitions :to => :to_contact
    end

	event :contact do
      transitions :to => :attempting_to_reach
    end

    event :receive_reply do
      transitions :to => :in_conversation
    end

    event :discuss do
      transitions :to => :touching_base
    end
	end

	scope :contacting, -> { where(state: 'attempting_to_reach') }
end
