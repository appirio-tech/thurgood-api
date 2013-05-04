class Server < ActiveRecord::Base
  attr_accessible :installed_services, :instance_url, :languages, :name, :operating_system, :password, :platform, :repo_name, :status, :username
end
