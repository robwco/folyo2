class DowngradeUser
  def self.call(user)
    free_plan = Plan.active.free.first

    return false if free_plan.blank?

    CreateSubscription.call(free_plan, user)
  end
end
