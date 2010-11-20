require 'spec_helper'

describe "clients/index.html.haml" do
  before(:each) do
    assign(:clients, [
      stub_model(Client,
        :name => "Name",
        :url => "Url"
      ),
      stub_model(Client,
        :name => "Name",
        :url => "Url"
      )
    ])
  end

  it "renders a list of clients" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Url".to_s, :count => 2
  end
end
