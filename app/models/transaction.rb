# frozen_string_literal: true

class Transaction < ApplicationRecord
	belongs_to :user
	after_create :update_loyalty_points

  # Validation
  validates_presence_of :amount, :payment_mode

  DEFAULT_PAYMENTS = ["Cash", "UPI", "Credit Card", "Debit Card"].freeze

  # After create callback to update loyalty points
  def update_loyalty_points
    UpdateLoyaltyPointsJob.perform_now(user.id, id)
  end
end
