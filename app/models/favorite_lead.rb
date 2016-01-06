class FavoriteLead < ActiveRecord::Base
	include AASM
  belongs_to :lead
  belongs_to :user

  aasm column: 'state' do
		state :to_contact, initial: true
		state :waiting_to_hear_back
		state :in_conversation
		state :staying_in_touch

	  event :move_to_to_contact do
      transitions :to => :to_contact
    end

	  event :move_to_waiting_to_hear_back do
      transitions :to => :waiting_to_hear_back
    end

    event :move_to_in_conversation do
      transitions :to => :in_conversation
    end

    event :move_to_staying_in_touch do
      transitions :to => :staying_in_touch
    end
	end

	scope :moved_to_to_contact, -> { where(state: 'to_contact') }
  scope :moved_to_waiting_to_hear_back, -> { where(state: 'waiting_to_hear_back') }
  scope :moved_to_in_conversation, -> { where(state: 'in_conversation') }
  scope :moved_to_staying_in_touch, -> { where(state: 'staying_in_touch') }
end