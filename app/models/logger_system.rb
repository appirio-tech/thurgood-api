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
		raise ApiExceptions::ProcessError.new "Required fields to create a Logger System are 
			missing: #{self.errors.full_messages}" if !valid?
		pt_system = Hashie::Mash.new Papertrail.create_system(papertrail_id, name, papertrail_account_id)
		if pt_system.has_key?('syslog_hostname') 
			self.syslog_port = pt_system['syslog_port']
			self.syslog_hostname = pt_system['syslog_hostname']
			self
		else
			raise ApiExceptions::ProcessError.new pt_system['message']
		end
	end  
end
