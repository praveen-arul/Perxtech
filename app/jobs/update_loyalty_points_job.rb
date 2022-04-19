class UpdateLoyaltyPointsJob < ApplicationJob
  queue_as :default

  def initialize(user_id, transaction_id)
    @transaction = Transaction.find(transaction_id)
    @user = User.find(user_id)
  end

  # Perform job to update and loyalty points and loyalty tier
  def perform
    update_loyalty_points
    update_points_earned
    UpdateLoyaltyTierJob.perform_later(@user.id)
  end

  # Updating loyalty points in user
  def update_loyalty_points
    @user.update(total_loyalty_points: loyalty_points + @user.total_loyalty_points)
  end

  # Generating and updating loyalty points in transactions
  def update_points_earned
    @transaction.update(points_generated: loyalty_points)
  end

  # Generating the loyalty points based on rule sets
  def loyalty_points
    (@transaction.amount / 100 * (@user.country == User::DEFAULT_COUNTRY ? 10 : 20))
  end
end
