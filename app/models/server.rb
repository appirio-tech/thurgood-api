class Server < ActiveRecord::Base
	include ApiExceptions

  attr_accessible :installed_services, :instance_url, :languages, 
	  :name, :operating_system, :password, :platform, :repo_name, 
	  :status, :username

	validates :instance_url, :languages, :name, :username, :password, 
		:platform, :repo_name, :status, presence: true
	validates :name, :repo_name, uniqueness: true

	def self.available(language, platform)
		where("status = ? and languages = ? and platform = ?", "available", language.downcase, platform.downcase).first
	end

	def self.reserve(job_id, language, platform)
		server = Server.available(language, platform)
		if server
			server.status = 'reserved'
			server.job_id = job_id
			if  server.save
				server
			else
				raise ApiExceptions::ProcessError.new "Error reserving server: #{server.errors.full_messages}"		
			end
		else
			raise ApiExceptions::ServerNotAvailableError.new "Requested server for #{language} and #{platform} is not available."
		end
	end

end