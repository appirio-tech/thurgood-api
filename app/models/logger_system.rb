class LoggerSystem < ActiveRecord::Base
  attr_accessible :logger_account_id, :name, :papertrail_id, 
	  :papertrail_account_id, :syslog_port, :syslog_hostname

  validates :name, :logger_account_id, presence: true
	before_validation :add_papertrail_id

  has_one :logger_account

  def add_papertrail_id
  	self.papertrail_id = SecureRandom.hex unless self.papertrail_id
	end	  

	def setup
		if !valid?
			raise ApiExceptions::ProcessError.new "Required fields to create a Logger System are missing: #{self.errors.full_messages}"
			Rails.logger.info "Required fields to create a Logger System are missing: #{self.errors.full_messages}"
		end
		pt_system = Hashie::Mash.new Papertrail.create_system(papertrail_id, name, papertrail_account_id)
		Rails.logger.info "new pt_system: #{pt_system.to_yaml}"
		if pt_system.has_key?('syslog_hostname') 
			self.syslog_port = pt_system['syslog_port']
			self.syslog_hostname = pt_system['syslog_hostname']
			self
		else
			Rails.logger.info "pt message: #{pt_system['message']}"
			raise ApiExceptions::ProcessError.new pt_system['message']
		end
	end  
end
