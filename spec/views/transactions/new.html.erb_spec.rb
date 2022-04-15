require 'rails_helper'

RSpec.describe "transactions/new", type: :view do
  before(:each) do
    assign(:transaction, Transaction.new(
      amount: 1,
      points_generated: 1,
      payment_mode: "MyString"
    ))
  end

  it "renders new transaction form" do
    render

    assert_select "form[action=?][method=?]", transactions_path, "post" do

      assert_select "input[name=?]", "transaction[amount]"

      assert_select "input[name=?]", "transaction[points_generated]"

      assert_select "input[name=?]", "transaction[payment_mode]"
    end
  end
end
