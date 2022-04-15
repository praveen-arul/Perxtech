require 'rails_helper'

RSpec.describe "transactions/edit", type: :view do
  before(:each) do
    @transaction = assign(:transaction, Transaction.create!(
      amount: 1,
      points_generated: 1,
      payment_mode: "MyString"
    ))
  end

  it "renders the edit transaction form" do
    render

    assert_select "form[action=?][method=?]", transaction_path(@transaction), "post" do

      assert_select "input[name=?]", "transaction[amount]"

      assert_select "input[name=?]", "transaction[points_generated]"

      assert_select "input[name=?]", "transaction[payment_mode]"
    end
  end
end
