class ImportedSubscription < ActiveRecord::Base
  belongs_to :user

  def import_subscription
	  return false unless self.user_id.nil?

	  ImportSubscription.call(self)
  end

  def self.import(subscriptions)
	subscriptions.each do |subscription|
		unless ImportedSubscription.exists?(:memberful_id => subscription["member"]["id"])
			imported_subscription = ImportedSubscription.new

			imported_subscription.memberful_id = subscription["member"]["id"]
			imported_subscription.name = subscription["member"]["full_name"]
			imported_subscription.email = subscription["member"]["email"]
			imported_subscription.memberful_plan_id = subscription["plan"]["id"]
			imported_subscription.renews = subscription["renew_at_end_of_period"]
			imported_subscription.stripe_customer_id = subscription["member"]["stripe_customer_id"]
			imported_subscription.subscription_start = Time.at subscription["created_at"]
			imported_subscription.subscription_end = Time.at subscription["expires_at"]

			imported_subscription.save!
		end
	end
  end
end
