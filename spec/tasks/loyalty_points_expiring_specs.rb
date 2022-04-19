# frozen_string_literal: true
Rails.application.load_tasks

RSpec.describe "loyalty_points_providing_bonus" do
  describe '#expiring loyalty points at the end of every year' do
    context 'expiring loyalty points' do
      let!(:user) { create(:user, :default_country, total_loyalty_points: 1000) }

      it 'should not expire the loyalty points at current year' do
        Rake::Task["loyalty_points:expiring"].execute
        user.reload
        expect(user.total_loyalty_points).to eq 1000
      end

      it 'should expire previous year loyalty points' do
        user.update(created_at: Date.today - 1.year)
        Rake::Task["loyalty_points:expiring"].execute
        user.reload
        expect(user.total_loyalty_points).to eq 0
      end
    end
  end
end
