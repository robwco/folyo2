class User < ActiveRecord::Base
  include AASM	
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  aasm column: 'state' do
	state :pending, initial: true
	state :trialing
	state :active
	state :past_due
	state :overdue_canceled
	state :user_canceled
	state :trial_canceled

	event :subscribe do
		transitions from: :pending, to: :trialing, if: :plan_has_trial?
		transitions from: :pending, to: :active, unless: :plan_has_trial?
  	end

	event :overdue do
		transitions from: :active, to: :past_due
		transitions from: :trialing, to: :trial_canceled
	end

	event :pay do
		transitions from: :trialing, to: :active
		transitions from: :past_due, to: :active
	end

	event :reactivate do
		transitions from: :overdue_canceled, to: :active
		transitions from: :user_canceled, to: :active
		transitions from: :trial_canceled, to: :active
	end

	event :cancel do
		transitions from: :trialing, to: :trial_canceled
		transitions from: :active, to: :user_canceled
		transitions from: :past_due, to: :overdue_canceled
	end
  end
         
  has_one :subscription, dependent: :destroy
  has_many :people
  has_and_belongs_to_many :categories, dependent: :destroy

  def canceled?
	  trial_canceled? || user_canceled? || overdue_canceled?
  end

  def good_standing?
	  !(canceled? || past_due?)
  end

  private
  	def plan_has_trial?
		subscription.plan.has_trial?
	end

end
