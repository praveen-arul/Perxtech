class AirportLoungeRewardsJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user(user_id).user_rewards.find_or_create_by(reward: Reward.filter_by_name('Airport Lounge Access Reward'))
  end

  def user(id)
    @user ||= User.find(id)
  end
end
