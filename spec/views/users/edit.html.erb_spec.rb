require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      first_name: "MyString",
      last_name: "MyString",
      total_loyalty_points: 1,
      tier: 1,
      country: "MyString"
    ))
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(@user), "post" do

      assert_select "input[name=?]", "user[first_name]"

      assert_select "input[name=?]", "user[last_name]"

      assert_select "input[name=?]", "user[total_loyalty_points]"

      assert_select "input[name=?]", "user[tier]"

      assert_select "input[name=?]", "user[country]"
    end
  end
end
