class LoggerAccount < ActiveRecord::Base
  attr_accessible :email, :name, :papertrail_id, :papertrail_api_token

  has_many :logger_system

  before_validation :add_papertrail_id

	validates :email, :name, :papertrail_id, presence: true
	validates :email, :papertrail_id, uniqueness: true  

  def add_papertrail_id
  	self.papertrail_id = SecureRandom.hex unless self.papertrail_id
	end	

	def setup
		raise ApiExceptions::ProcessError.new 'Required fields to create a Logger Account are missing.' if !valid?
		pt_account = Hashie::Mash.new Papertrail.create_account(papertrail_id, name, email)
		if pt_account.has_key?('api_token') 
			self.papertrail_api_token = pt_account['api_token']
			self.papertrail_id = pt_account['id']
			self
		else
			raise ApiExceptions::ProcessError.new "The Logger Account already exists."
		end
	end
end
