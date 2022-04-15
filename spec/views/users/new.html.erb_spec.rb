require 'rails_helper'

RSpec.describe "users/new", type: :view do
  before(:each) do
    assign(:user, User.new(
      first_name: "MyString",
      last_name: "MyString",
      total_loyalty_points: 1,
      tier: 1,
      country: "MyString"
    ))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input[name=?]", "user[first_name]"

      assert_select "input[name=?]", "user[last_name]"

      assert_select "input[name=?]", "user[total_loyalty_points]"

      assert_select "input[name=?]", "user[tier]"

      assert_select "input[name=?]", "user[country]"
    end
  end
end
