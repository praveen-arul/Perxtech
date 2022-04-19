# frozen_string_literal: true

RSpec.describe AirportLoungeRewardsJob, type: :job do
  describe '#airport lounge reward for Gold tier users' do
    context 'airport lounge reward' do
      let!(:user) { create(:user, :default_country) }
      let!(:reward) { create(:reward, name: 'Airport Lounge Access Reward') }

      it 'should not provide AirportLoungeRewards for the customers having less than 1000 loyalty points' do
        user.update(total_loyalty_points: 100)
        AirportLoungeRewardsJob.perform_now(user.id)
        expect(user.rewards.first).to be nil
      end

      it 'should not provide AirportLoungeRewards for the customers having greater than 1000 loyalty points' do
        user.update(total_loyalty_points: 1000)
        AirportLoungeRewardsJob.perform_now(user.id)
        expect(user.rewards.first.name).to eq 'Airport Lounge Access Reward'
      end

      it 'should not provide AirportLoungeRewards for Standard tier customers' do
        user.update(tier: 'standard')
        AirportLoungeRewardsJob.perform_now(user.id)
        expect(user.rewards.first).to be nil
      end

      it 'should provide AirportLoungeRewards for Gold tier customers' do
        user.update(tier: 'gold')
        AirportLoungeRewardsJob.perform_now(user.id)
        expect(user.rewards.first.name).to eq 'Airport Lounge Access Reward'
      end

      it 'should not provide AirportLoungeRewards for the customers having 0 loyalty points' do
        user.update(total_loyalty_points: 0)
        AirportLoungeRewardsJob.perform_now(user.id)
        expect(user.rewards.first).to be nil
      end
    end
  end
end
