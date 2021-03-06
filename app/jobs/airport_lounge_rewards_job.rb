# frozen_string_literal: true

class AirportLoungeRewardsJob < ApplicationJob
  queue_as :default

  # Perform job to provide AirportLounge reward
  def perform(user_id)
    if user(user_id).gold? || @user.total_loyalty_points >= 1000
      @user.user_rewards.find_or_create_by(reward: Reward.filter_by_name('Airport Lounge Access Reward'))
    end
  end

  # Fetching user
  def user(id)
    @user ||= User.find(id)
  end
end
