class AddStatusToUserRewards < ActiveRecord::Migration[6.1]
  def change
    add_column :user_rewards, :status, :string, default: :active, null: false
  end
end
