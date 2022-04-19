# frozen_string_literal: true

Rails.application.load_tasks

RSpec.describe 'loyalty_points_providing_bonus' do
  describe '#providing bonus points for customers' do
    context 'bonus points' do
      let!(:user) { create(:user, :default_country) }
      let!(:transaction) { create(:transaction, user_id: user.id, amount: 100) }

      it 'should not provide Bonus points for the customers who did not made transaction > 2000 in current quater' do
        user.reload
        loyalty_points = user.total_loyalty_points
        Rake::Task['loyalty_points:providing_bonus'].execute
        user.reload
        expect(user.total_loyalty_points).to eq(loyalty_points)
      end
    end

    context 'bonus points' do
      let!(:user) { create(:user, :default_country) }
      let!(:transaction) { create(:transaction, user_id: user.id, amount: 100, created_at: Date.today - 4.months) }
      it 'should not provide Bonus points for the customers who transaction > 2000 but not in current quater' do
        user.reload
        loyalty_points = user.total_loyalty_points
        Rake::Task['loyalty_points:providing_bonus'].execute
        user.reload
        expect(user.total_loyalty_points).to eq(loyalty_points)
      end
    end
  end
end
