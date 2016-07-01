class User < ActiveRecord::Base
  include AASM	
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :favorite_leads
  has_many :favorites, through: :favorite_leads, source: :lead
  
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
  has_and_belongs_to_many :milestone, dependent: :destroy

  has_attached_file :photo, :styles => { :medium => "190x190>", :thumb => "190x190>" }
  validates_attachment_content_type :photo, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  scope :active, -> { where(:state => ['trialing','active','past_due']) }
  scope :with_favorites, -> { where("favorite_leads is not null") }
  scope :following_ruby, -> { where("category_id=1 is not null") }

  def self.with_stripe_id(stripe_id)
		where("users.stripe_customer_id = ?", stripe_id).first
  end

  def canceled?
	  trial_canceled? || user_canceled? || overdue_canceled?
  end

  def good_standing?
	  !(canceled? || past_due?)
  end

  def update_card(card)
	  self.last4 = card.last4
	  self.expiration_month = card.exp_month
	  self.expiration_year = card.exp_year
  end

  def update_card!(card)
	  update_card card
	  save!
  end

  def billing_period_end
	  return "" if subscription.current_period_end.nil?
	  subscription.current_period_end.to_date.to_formatted_s(:long)
  end

  def can_reply_to_project?(project)
	project.allow_replies_from?(self) && (self.subscription.allow_replies_to_projects? || project.allow_portfolio_replies? || enough_time_since_last_reply?)
  end

  def can_reply_with_portfolio?(project)
    (project.present? && project.allow_portfolio_replies?) || self.subscription.allow_portfolio_replies?    
  end

  def can_see_leads?
	self.subscription.allow_leads?
  end

  def can_see_project_replies?(project)
	project.user == self
  end

  def can_see_messages?(reply)
	return false if reply.blank?
	reply.project.user == self || reply.user == self
  end

  def can_send_message?(reply)
	reply.project.user == self || (reply.user == self && reply.messages.count > 0)
  end

  private
  	def plan_has_trial?
		subscription.plan.has_trial?
	end

	def enough_time_since_last_reply?
        latest_reply = Reply.replies_from(self).maximum(:published_at)
        return true if latest_reply.blank?
        (latest_reply + 1.week) < Time.now
   end

end
