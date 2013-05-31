class Server < ActiveRecord::Base
	include ApiExceptions

  attr_accessible :installed_services, :instance_url, :languages, 
    :name, :operating_system, :password, :platform, :repo_name, 
    :status, :username

  validates :instance_url, :languages, :name, :username, :password, 
    :platform, :repo_name, :status, presence: true
  validates :name, :repo_name, uniqueness: true

  def self.available(language, platform)
    where("status = ? and languages = ? and platform = ?", "available", 
    language.downcase, platform.downcase).first
  end

  #
  # Marks a server as reserved for a specific job
  # * *Args*    :
  #   - job_id -> the id of the job
  #   - language -> the language for the server being reserved
  #   - platform -> the platform for the server being reserved
  # * *Returns* :
  #   - the record of the server reserved
  # * *Raises* :
  #   - ++ -> ApiExceptions::ProcessError - if unable to save record
  #   - ++ -> ApiExceptions::ServerNotAvailableError - if a server is not available
  #    for the requested language and type
  def self.reserve(job_id, language, platform)
    server = Server.available(language, platform)
    Rails.logger.info "[INFO]Found available server: #{server}"
    if server
      server.status = 'reserved'
      server.job_id = job_id
      Rails.logger.info "[INFO]"
      if  server.save
        Rails.logger.info "[INFO] Reserved server: #{server}"
        server
      else
        Rails.logger.info "[INFO] Error reserving server: #{server.errors.full_messages}"  
        raise ApiExceptions::ProcessError.new "Error reserving server: #{server.errors.full_messages}"		
      end
    else
      Rails.logger.info "[INFO]Requested server for #{language} and #{platform} is not available."
      raise ApiExceptions::ServerNotAvailableError.new "Requested server for #{language} and #{platform} is not available."
    end
  end

  def release
    Rails.logger.info "[INFO] Releasing server"
    self.status = 'available'
    self.job_id = ''
    save
  end

end