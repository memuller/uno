require 'spec_helper'

describe "users/show.html.haml" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :email => "Email",
      :full_name => "Full Name",
      :password_hash => "Password Hash"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Email/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Full Name/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Password Hash/)
  end
end
