class LoggerAccount < ActiveRecord::Base
  attr_accessible :email, :name, :papertrail_id, :papertrail_api_token

  has_many :logger_system

	validates :email, :name, :papertrail_id, presence: true
	validates :papertrail_id, uniqueness: true  

  #
  # Creates a new account with Papertrail and saves results to db
  # * *Args*    :
  # * *Returns* :
  #   - self
  # * *Raises* :
  #   - ++ -> ApiExceptions::ProcessError - if the record is not valid for saving
	def setup
		raise ApiExceptions::ProcessError.new "Error creating Logger Account: #{self.errors.full_messages}" if !valid?
		pt_account = Hashie::Mash.new Papertrail.create_account(papertrail_id, name, email)
		# if no api_token then the account already exists in PT and this call returned an error
		pt_account = Papertrail.get_account(papertrail_id) if !pt_account.has_key?('api_token') 
		self.papertrail_api_token = pt_account['api_token']
		self.papertrail_id = pt_account['id']
		puts "Error inserting existing account into DB" if !self.save
		self		
	end
end
