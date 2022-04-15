require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        first_name: "First Name",
        last_name: "Last Name",
        total_loyalty_points: 2,
        tier: 3,
        country: "Country"
      ),
      User.create!(
        first_name: "First Name",
        last_name: "Last Name",
        total_loyalty_points: 2,
        tier: 3,
        country: "Country"
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", text: "First Name".to_s, count: 2
    assert_select "tr>td", text: "Last Name".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: "Country".to_s, count: 2
  end
end
