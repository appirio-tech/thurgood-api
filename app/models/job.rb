class Job < ActiveRecord::Base
	before_save :default_values

  attr_accessible :email, :endtime, :job_id, :language, :user_id,
  	:papertrail_system, :platform, :starttime, :status, :server_id,
  	:code_url

	validates :user_id, :code_url, :language, :platform, presence: true 

	def self.by_user_id(user_id)
		where("user_id = ?", user_id).order("created_at DESC")
	end

  def default_values
  	self.status = 'created' if !self.status
  	self.job_id = SecureRandom.hex if !self.job_id
	end

	# raises ServerNotAvailableError if servers by language and platform not available
	def submit
		check_for_previously_submitted_job
		server = Server.reserve(job_id, language, platform)
		setup_logger_account
		setup_logger_system
		self.status = 'in progress'
		self.starttime = DateTime.now
		if self.save
			# TODO -- kick off the job to thrugood-queue
		else
			raise ApiExceptions::ProcessError.new "Error! Could not submit job: 
				#{self.errors.full_messages}"			
		end
	end

	private

		def check_for_previously_submitted_job
			raise ApiExceptions::ProcessError.new "Job has already been submitted for 
				processing" if self.starttime
		end

		# @account.setup raises ProcessError if not able to setup the account with papertrail
		def setup_logger_account
			@account = LoggerAccount.find_by_papertrail_id(self.user_id)
			unless @account
				@account = LoggerAccount.new(:name => self.user_id, :email => self.email, 
					:papertrail_id => self.user_id)
				@account.setup
				raise ApiExceptions::ProcessError.new "Could not create logger 
					account: #{@account.errors.full_messages}" if !@account.save
			end
		rescue Exception => e
			raise ApiExceptions::ProcessError.new "Error creating logger account: #{e.message}"
		end

		def setup_logger_system
      system_logger = LoggerSystem.new :name => "#{self.user_id}-#{self.job_id}", :papertrail_id => self.job_id,
      	:papertrail_account_id => @account.papertrail_id, :logger_account_id => @account.id	
      system_logger.setup # create the system in papertrail
			raise ApiExceptions::ProcessError.new "Could not create logger 
				system: #{system_logger.errors.full_messages}" if !system_logger.save 
			self.papertrail_system =  system_logger.id   
		rescue Exception => e
			raise ApiExceptions::ProcessError.new "Error creating logger system: #{e.message}"			
		end

end
