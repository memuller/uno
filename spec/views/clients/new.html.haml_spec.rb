require 'spec_helper'

describe "clients/new.html.haml" do
  before(:each) do
    assign(:client, stub_model(Client,
      :name => "MyString",
      :url => "MyString"
    ).as_new_record)
  end

  it "renders new client form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => clients_path, :method => "post" do
      assert_select "input#client_name", :name => "client[name]"
      assert_select "input#client_url", :name => "client[url]"
    end
  end
end
