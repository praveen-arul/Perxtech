require 'rails_helper'

RSpec.describe UpdateLoyaltyTierJob, type: :job do
  describe '#update_loyalty tier based on loyalty points' do
    context 'loyalty tier' do
      let!(:user) { create(:user, :default_country, total_loyalty_points: 100) }

      it 'should have standard tier for less than 1000 loyalty points' do
        user.reload
        UpdateLoyaltyTierJob.perform_now(user.id)
        user.reload
        expect(user.tier).to eq 'standard'
      end
    end

    context 'loyalty tier' do
      let!(:user) { create(:user, :other_countries, total_loyalty_points: 1000) }

      it 'should have gold tier for greater than 1000 loyalty points' do
        user.reload
        UpdateLoyaltyTierJob.perform_now(user.id)
        user.reload
        expect(user.tier).to eq 'gold'
      end
    end

    context 'loyalty tier' do
      let!(:user) { create(:user, :other_countries, total_loyalty_points: 5000) }

      it 'should have platinum tier for greater than 5000 loyalty points' do
        user.reload
        UpdateLoyaltyTierJob.perform_now(user.id)
        user.reload
        expect(user.tier).to eq 'platinum'
      end
    end
  end
end
