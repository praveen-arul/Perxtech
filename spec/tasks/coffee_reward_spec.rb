# frozen_string_literal: true

Rails.application.load_tasks

RSpec.describe 'reward_providing_coffee_reward' do
  describe '#coffee rewards' do
    context 'coffee reward for customers having greater than 100 loyalty points or on their birthday month' do
      let!(:user) { create(:user, :default_country) }
      let!(:reward) { create(:reward, name: 'Free Coffee Reward') }

      it 'should not provide Coffee reward for the customers having < 90 loyalty points and not birthday month' do
        user.update(total_loyalty_points: 90, date_of_birth: Date.today - 2.months)
        user.reload
        Rake::Task['rewards:providing_coffee_rewards'].execute
        expect(user.rewards.first).to be nil
      end

      it 'should provide Coffee reward for the customers having birthday month' do
        user.update(date_of_birth: Date.today)
        create(:transaction, user_id: user.id, amount: 0)
        user.reload
        Rake::Task['rewards:providing_coffee_rewards'].execute
        user.reload
        expect(user.rewards.first.name).to eq 'Free Coffee Reward'
      end

      it 'should provide Coffee reward for the customers having > 100 loyalty points' do
        user.update(date_of_birth: Date.today - 2.months)
        create(:transaction, user_id: user.id, amount: 10_000)
        user.reload
        Rake::Task['rewards:providing_coffee_rewards'].execute
        user.reload
        expect(user.rewards.first.name).to eq 'Free Coffee Reward'
      end

      it 'should provide Coffee reward for the customers having > 100 loyalty points or birthday month' do
        user.update(date_of_birth: Date.today)
        create(:transaction, user_id: user.id, points_generated: 110)
        user.reload
        Rake::Task['rewards:providing_coffee_rewards'].execute
        user.reload
        expect(user.rewards.first.name).to eq 'Free Coffee Reward'
      end
    end
  end
end
