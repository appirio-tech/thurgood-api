require 'spec_helper'

describe "servers/index" do
  before(:each) do
    assign(:servers, [
      stub_model(Server,
        :name => "Name",
        :installed_services => "Installed Services",
        :instance_url => "Instance Url",
        :operating_system => "Operating System",
        :password => "Password",
        :platform => "Platform",
        :repo_name => "Repo Name",
        :status => "Status",
        :languages => "Languages",
        :username => "Username"
      ),
      stub_model(Server,
        :name => "Name",
        :installed_services => "Installed Services",
        :instance_url => "Instance Url",
        :operating_system => "Operating System",
        :password => "Password",
        :platform => "Platform",
        :repo_name => "Repo Name",
        :status => "Status",
        :languages => "Languages",
        :username => "Username"
      )
    ])
  end

  it "renders a list of servers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Installed Services".to_s, :count => 2
    assert_select "tr>td", :text => "Instance Url".to_s, :count => 2
    assert_select "tr>td", :text => "Operating System".to_s, :count => 2
    assert_select "tr>td", :text => "Password".to_s, :count => 2
    assert_select "tr>td", :text => "Platform".to_s, :count => 2
    assert_select "tr>td", :text => "Repo Name".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => "Languages".to_s, :count => 2
    assert_select "tr>td", :text => "Username".to_s, :count => 2
  end
end
