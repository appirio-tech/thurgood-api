require 'spec_helper'

describe "servers/show" do
  before(:each) do
    @server = assign(:server, stub_model(Server,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Installed Services/)
    rendered.should match(/Instance Url/)
    rendered.should match(/Operating System/)
    rendered.should match(/Password/)
    rendered.should match(/Platform/)
    rendered.should match(/Repo Name/)
    rendered.should match(/Status/)
    rendered.should match(/Languages/)
    rendered.should match(/Username/)
  end
end
