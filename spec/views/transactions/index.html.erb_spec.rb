require 'rails_helper'

RSpec.describe "transactions/index", type: :view do
  before(:each) do
    assign(:transactions, [
      Transaction.create!(
        amount: 2,
        points_generated: 3,
        payment_mode: "Payment Mode"
      ),
      Transaction.create!(
        amount: 2,
        points_generated: 3,
        payment_mode: "Payment Mode"
      )
    ])
  end

  it "renders a list of transactions" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: "Payment Mode".to_s, count: 2
  end
end
