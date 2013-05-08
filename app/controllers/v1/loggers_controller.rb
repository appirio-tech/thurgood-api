class V1::LoggersController < V1::ApplicationController
	jsonp		

	before_filter :check_if_account_exists, :only => [:account_create]

	def account_create
		logger_account = LoggerAccount.new(params[:account]).setup
		logger_account.save
		expose logger_account

	rescue ApiExceptions::ProcessError => e
		error! :bad_request, :metadata => 
			{:error_description => e.message, 
				:details => WIKI_LOGGER}
	rescue Exception => e
		error! :server_error, :metadata => 
			{:error_description => e.message}
	end

	def system_create
		logger_system = LoggerSystem.new(params[:system]).setup
		logger_system.save
		expose logger_system

	rescue ApiExceptions::ProcessError => e
		error! :bad_request, :metadata => 
			{:error_description => e.message, 
				:details => WIKI_LOGGER}
	rescue Exception => e
		error! :server_error, :metadata => 
			{:error_description => e.message}
	end

	private

		def check_if_account_exists
			existing_account = LoggerAccount.find_by_email(params[:account][:email])
			expose existing_account if existing_account
		rescue Exception => e
			error! :bad_request, :metadata => 
				{:error_description => "Required fields to create a Logger Account are missing.", 
					:details => WIKI_LOGGER}			
		end

end
