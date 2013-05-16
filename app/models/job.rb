require 'bunny'

class Job < ActiveRecord::Base
	before_save :default_values

  attr_accessible :email, :endtime, :job_id, :language, :user_id,
  	:papertrail_system, :platform, :starttime, :status, :server_id,
  	:code_url, :options

  serialize :options, JSON

	validates :user_id, :code_url, :language, :platform, presence: true 

	def self.by_user_id(user_id)
		where("user_id = ?", user_id).order("created_at DESC")
	end

  def default_values
  	self.status = 'created' if !self.status
  	self.job_id = SecureRandom.hex if !self.job_id
	end

	def submit(options)
		if options
			@system_papertrail_id = options[:system_papertrail_id] if options[:system_papertrail_id]
		end
		check_for_previously_submitted_job
		server = Server.reserve(job_id, language, platform)
		setup_logger_account
		setup_logger_system
		self.status = 'in progress'
		self.starttime = DateTime.now
		self.options = job_options(options) if options
		if self.save
			publish_job
		else
			raise ApiExceptions::ProcessError.new "Error! Could not submit job: #{self.errors.full_messages}"			
		end
		# temp
		Server.release(server.id)
	end

	def resubmit
		server = Server.reserve(job_id, language, platform)
		self.status = 'in progress'
		self.starttime = DateTime.now
		if self.save
			publish_job
		else
			raise ApiExceptions::ProcessError.new "Error! Could not resubmit job: #{self.errors.full_messages}"			
		end
		# temp
		Server.release(server.id)
	end	

	private

		def job_options(options)
			options = options.to_hash
			options.remove_key!('system_papertrail_id')
			options.to_json
		end

		def publish_job
			message = { :job_id => self.job_id, :type => self.language }		
			b = Bunny.new ENV['CLOUDAMQP_URL']
			b.start
			q = b.queue(ENV['THURGOOD_MAIN_QUEUE'])
			q.publish(message.to_json)
			b.stop			
		end

		def check_for_previously_submitted_job
			raise ApiExceptions::ProcessError.new "Job has already been submitted for processing" if self.starttime
		end

		# @account.setup raises ProcessError if not able to setup the account with papertrail
		def setup_logger_account
			@account = LoggerAccount.find_by_papertrail_id(self.user_id)
			unless @account
				@account = LoggerAccount.new(:name => self.user_id, :email => self.email, 
					:papertrail_id => self.user_id)
				@account.setup
				raise ApiExceptions::ProcessError.new "Could not create logger account: #{@account.errors.full_messages}" if !@account.save
			end
		rescue Exception => e
			raise ApiExceptions::ProcessError.new "Error creating logger account: #{e.message}"
		end

		def setup_logger_system
			system_papertrail_id = self.job_id
			system_papertrail_id = @system_papertrail_id if @system_papertrail_id
      system_logger = LoggerSystem.new :name => "#{self.user_id}-#{self.job_id}", 
	      :papertrail_id => system_papertrail_id, :papertrail_account_id => @account.papertrail_id, 
	      :logger_account_id => @account.id	
	    puts "system_logger #{system_logger.to_yaml}"
      system_logger.setup # create the system in papertrail
			raise ApiExceptions::ProcessError.new "Could not create logger system: #{system_logger.errors.full_messages}" if !system_logger.save 
			self.papertrail_system =  system_logger.id   
		rescue Exception => e
			raise ApiExceptions::ProcessError.new "Error creating logger system: #{e.message}"			
		end

end
