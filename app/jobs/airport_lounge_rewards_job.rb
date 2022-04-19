class AirportLoungeRewardsJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    @user.user_rewards.find_or_create_by(reward: Reward.filter_by_name('Airport Lounge Access Reward')) if user(user_id).gold? || @user.total_loyalty_points >= 1000
  end

  def user(id)
    @user ||= User.find(id)
  end
end
