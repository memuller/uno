require 'spec_helper'

describe "users/new.html.haml" do
  before(:each) do
    assign(:user, stub_model(User,
      :email => "MyString",
      :full_name => "MyString",
      :password_hash => "MyString"
    ).as_new_record)
  end

  it "renders new user form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => users_path, :method => "post" do
      assert_select "input#user_email", :name => "user[email]"
      assert_select "input#user_full_name", :name => "user[full_name]"
      assert_select "input#user_password_hash", :name => "user[password_hash]"
    end
  end
end
