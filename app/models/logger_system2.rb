class LoggerSystem2

  def self.find(job)
    options = { 
      :headers => api_request_headers   
    }
    logger2 = Hashie::Mash.new HTTParty.get("#{ENV['THURGOOD_V2_URL']}/loggers/#{job['papertrail_system']}", options)
    if logger2.success && !logger2.data.empty?
      data = logger2.data.first
      logger = LoggerSystem.new
      logger.id = 0
      logger.created_at = data.createdAt
      logger.logger_account_id = data.loggerAccountId
      logger.name = data.name
      logger.papertrail_account_id = data.loggerAccountId
      logger.papertrail_id = data.papertrailId
      logger.syslog_hostname = data.syslogHostname
      logger.syslog_port = data.syslogPort
      logger.updated_at = data.updatedAd
      return logger
    end    
  end

    def self.api_request_headers
      {
        'Authorization' => 'Token token="'+ENV['THURGOOD_V2_API_KEY']+'"',
        'Content-Type' => 'application/json'
      }
    end         

end