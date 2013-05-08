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

	def reserve
		raise ApiExceptions::ServerNotAvailableError.new 'Requested server is not available'
	end

end