require 'spec_helper'

describe "clients/edit.html.haml" do
  before(:each) do
    @client = assign(:client, stub_model(Client,
      :new_record? => false,
      :name => "MyString",
      :url => "MyString"
    ))
  end

  it "renders the edit client form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => client_path(@client), :method => "post" do
      assert_select "input#client_name", :name => "client[name]"
      assert_select "input#client_url", :name => "client[url]"
      assert_select "input#client_admin_user_email", :name => 'client[admin_user_email]'
    end
  end
end
