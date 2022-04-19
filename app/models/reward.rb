class Reward < ApplicationRecord
	has_many :user_rewards, dependent: :destroy
  has_many :users, through: :user_rewards

	scope :filter_by_name, ->(reward_name) { find_by('name = ?', reward_name) }

end
