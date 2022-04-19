class Transaction < ApplicationRecord
	belongs_to :user

	after_create :update_loyalty_points

  DEFAULT_PAYMENTS = ["Cash", "UPI", "Credit Card", "Debit Card"]

  def update_loyalty_points
    UpdateLoyaltyPointsJob.perform_now(user.id, id)
  end
end
