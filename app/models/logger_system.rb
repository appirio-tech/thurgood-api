class LoggerSystem < ActiveRecord::Base
  attr_accessible :logger_account_id, :name, :papertrail_id, 
	  :papertrail_account_id, :syslog_port, :syslog_hostname

  validates :name, :logger_account_id, presence: true
	before_validation :add_papertrail_id

  has_one :logger_account

  def self.fetch(job)
  	if job['version'] == 1
  		LoggerSystem.find(job.papertrail_system)
  	else
		LoggerSystem2.find(job)
  	end
  end

  def add_papertrail_id
  	self.papertrail_id = SecureRandom.hex unless self.papertrail_id
	end	  

	def setup
		raise ApiExceptions::ProcessError.new "Required fields to create a Logger System are missing: #{self.errors.full_messages}" if !valid?
		pt_system = lookup_papertrail_system
		if pt_system.has_key?('syslog_hostname') 
			self.syslog_port = pt_system['syslog_port']
			self.syslog_hostname = pt_system['syslog_hostname']
			self
		else
			raise ApiExceptions::ProcessError.new pt_system['message']
		end
	end  

	private

		def lookup_papertrail_system
			existing_system = LoggerSystem.find_by_papertrail_id(papertrail_id)
			if existing_system
				system = Hashie::Mash.new
				system.syslog_port = existing_system.syslog_port 
				system.syslog_hostname = existing_system.syslog_hostname
				system
			else
				Hashie::Mash.new Papertrail.create_system(papertrail_id, name, papertrail_account_id)				
			end
		end

end
