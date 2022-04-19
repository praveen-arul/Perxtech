class UpdateLoyaltyPointsJob < ApplicationJob
  queue_as :default

  def initialize(user_id, transaction_id)
    @transaction = Transaction.find(transaction_id)
    @user = User.find(user_id)
  end

  def perform
    update_loyalty_points
    update_points_earned
    UpdateLoyaltyTierJob.perform_later(@user.id)
  end

  def update_loyalty_points
    @user.update(total_loyalty_points: loyalty_points + @user.total_loyalty_points)
  end

  def update_points_earned
    @transaction.update(points_generated: loyalty_points)
  end

  def loyalty_points
    (@transaction.amount / 100 * (@user.country == User::DEFAULT_COUNTRY ? 10 : 20))
  end
end
