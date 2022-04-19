# frozen_string_literal: true

namespace :rewards_expiring do
  desc "expiring rewards after 1year by changing the status"

  # Expiring rewards after 1year by changing the status
  task after_1year: :environment do
    UserReward.where('created_at < ?', (DateTime.now - 1.year)).update_all(status: 'inactive')
  end
end
