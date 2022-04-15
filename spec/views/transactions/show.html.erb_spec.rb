require 'rails_helper'

RSpec.describe "transactions/show", type: :view do
  before(:each) do
    @transaction = assign(:transaction, Transaction.create!(
      amount: 2,
      points_generated: 3,
      payment_mode: "Payment Mode"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Payment Mode/)
  end
end
