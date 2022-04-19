class UpdateLoyaltyTierJob < ApplicationJob
  queue_as :default

  # Perform job to update loyalty tier and provide Airport Lounge reward
  def perform(user_id)
    user(user_id).update(tier: loyalty_tier)
    AirportLoungeRewardsJob.perform_later(@user.id) if @user.gold?
  end

  # fetching loyalty tier for the user
  def loyalty_tier
    case @user.total_loyalty_points
    when 0...1000
      'standard'
    when 1000...5000
      'gold'
    else
      'platinum'
    end
  end

  # Fetching user
  def user(id)
    @user ||= User.find(id)
  end
end
