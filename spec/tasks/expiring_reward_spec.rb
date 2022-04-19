# frozen_string_literal: true

Rails.application.load_tasks

RSpec.describe 'expiring rewards' do
  describe '#expiring rewards after 1 year' do
    context 'expiring loyalty points' do
      let!(:user) { create(:user, :default_country) }
      let!(:reward) { create(:reward, name: 'Free Coffee Reward') }
      let!(:user_reward) { create(:user_reward, user_id: user.id, reward_id: reward.id) }

      it 'rewards should be active for 1 year' do
        Rake::Task['rewards_expiring:after_1year'].execute
        user_reward.reload
        expect(user_reward.active?).to be true
      end

      it 'rewards should be expired after 1 year' do
        user_reward.update(created_at: DateTime.now - 1.year)
        Rake::Task['rewards_expiring:after_1year'].execute
        user_reward.reload
        expect(user_reward.active?).to be false
      end
    end
  end
end
