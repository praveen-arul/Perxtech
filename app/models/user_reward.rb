# frozen_string_literal: true

class UserReward < ApplicationRecord
  belongs_to :user
  belongs_to :reward

  enum status: { active: 'active', inactive: 'inactive' }
end
