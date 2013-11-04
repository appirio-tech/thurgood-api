require 'uri'

class Server2

  def self.find_by_job_id(id)
    options = { 
      :headers => api_request_headers   
    }
    puts "#{ENV['THURGOOD_V2_URL']}/servers?q=#{URI.escape({:jobId => id}.to_json)}"
    server2 = Hashie::Mash.new HTTParty.get("#{ENV['THURGOOD_V2_URL']}/servers?q=#{URI.escape({:jobId => id}.to_json)}", options)
    puts server2.to_yaml
    if server2.success
      data = server2.data.first
      server = Server.new
      server.created_at = data.createdAt
      server.installed_services = data.installedServices.join(",")
      server.instance_url = data.instanceUrl
      server.job_id = id
      server.languages = data.languages.join(",")
      server.name = data.name
      server.operating_system = data.operatingSystem
      server.password = data.password
      server.platform = data.platform
      server.repo_name = data.repoName
      server.status = data.status
      server.username = data.username
      return server
    end

  end

    def self.api_request_headers
      {
        'Authorization' => 'Token token="'+ENV['THURGOOD_V2_API_KEY']+'"',
        'Content-Type' => 'application/json'
      }
    end       

end