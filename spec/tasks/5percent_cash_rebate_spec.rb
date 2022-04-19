# frozen_string_literal: true
Rails.application.load_tasks

RSpec.describe "5percent_cash_rebate" do
  describe '#5% Cash Rebates' do
    context 'cash rebates' do
      let!(:user) { create(:user, :default_country) }

      it 'should not provide 5% Cash Rebate for the customers having less than 10 transactions' do
        create_list(:transaction, 5, user_id: user.id)
        Rake::Task["rewards:providing_5percent_cash_rewards"].execute
        expect(user.rewards.first).to be nil
      end

      it 'should not provide 5% Cash Rebate for the customers having less than 10 transactions < 100 dollars' do
        create_list(:transaction, 9, user_id: user.id)
        Rake::Task["rewards:providing_5percent_cash_rewards"].execute
        expect(user.rewards.first).to be nil
      end

      it 'should not provide 5% Cash Rebate for the customers having less than 10 transactions > 100 dollars' do
        create_list(:transaction, 10, user_id: user.id)
        Rake::Task["rewards:providing_5percent_cash_rewards"].execute
        expect(user.rewards.first.name).to eq '5% Cash Rebate'
      end
    end
  end
end
