require 'spec_helper'

describe "users/edit.html.haml" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :new_record? => false,
      :email => "MyString",
      :full_name => "MyString",
      :password_hash => "MyString"
    ))
  end

  it "renders the edit user form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => user_path(@user), :method => "post" do
      assert_select "input#user_email", :name => "user[email]"
      assert_select "input#user_full_name", :name => "user[full_name]"
      assert_select "input#user_password_hash", :name => "user[password_hash]"
    end
  end
end
