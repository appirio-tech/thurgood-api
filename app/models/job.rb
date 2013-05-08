class Job < ActiveRecord::Base
	before_save :default_values

  attr_accessible :email, :endtime, :job_id, :language, 
  	:papertrail_system, :platform, :starttime, :status, :server_id

	validates :email, :language, :platform, presence: true 

	def self.by_email(email)
		where("email = ?", email).order("created_at DESC")
	end

  def default_values
  	self.status = 'created'
  	self.job_id = SecureRandom.hex
	end

	def submit
		# find an available server
		server = Server.available(language, platform)
		puts server
	end


end
