require 'spec_helper'

describe "servers/edit" do
  before(:each) do
    @server = assign(:server, stub_model(Server,
      :name => "MyString",
      :installed_services => "MyString",
      :instance_url => "MyString",
      :operating_system => "MyString",
      :password => "MyString",
      :platform => "MyString",
      :repo_name => "MyString",
      :status => "MyString",
      :languages => "MyString",
      :username => "MyString"
    ))
  end

  it "renders the edit server form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", server_path(@server), "post" do
      assert_select "input#server_name[name=?]", "server[name]"
      assert_select "input#server_installed_services[name=?]", "server[installed_services]"
      assert_select "input#server_instance_url[name=?]", "server[instance_url]"
      assert_select "input#server_operating_system[name=?]", "server[operating_system]"
      assert_select "input#server_password[name=?]", "server[password]"
      assert_select "input#server_platform[name=?]", "server[platform]"
      assert_select "input#server_repo_name[name=?]", "server[repo_name]"
      assert_select "input#server_status[name=?]", "server[status]"
      assert_select "input#server_languages[name=?]", "server[languages]"
      assert_select "input#server_username[name=?]", "server[username]"
    end
  end
end
