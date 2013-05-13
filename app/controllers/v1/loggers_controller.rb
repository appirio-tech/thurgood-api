class V1::LoggersController < V1::ApplicationController
	jsonp		

	before_filter :check_if_account_exists, :only => [:account_create]

	def account_show
		account = LoggerAccount.find_by_papertrail_id(params[:id])
		expose account if account
		error! :not_found, :metadata => {:details => WIKI_LOGGER} if !account			
	end

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

	def account_delete
		Papertrail.delete_account(params[:id])
		LoggerAccount.find_by_papertrail_id(params[:id]).destroy
		expose 'true'
	rescue Exception => e
		error! :server_error, :metadata => 
			{:error_description => 'Error deleting Account.'}
	end	

	def account_systems
		expose LoggerSystem.where("papertrail_account_id = ?", params[:id])
	end	

	def system_show
		system = LoggerSystem.find_by_papertrail_id(params[:id])
		expose system if system
		error! :not_found, :metadata => {:details => WIKI_LOGGER} if !system		
	end	

	def system_delete
		Papertrail.delete_system(params[:id])
		LoggerSystem.find_by_papertrail_id(params[:id]).destroy
		expose 'true'
	rescue Exception => e
		error! :server_error, :metadata => 
			{:error_description => 'Error deleting System.'}		
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
			existing_account = LoggerAccount.find_by_papertrail_id(params[:account][:papertrail_id])
			expose existing_account if existing_account
		rescue Exception => e
			error! :bad_request, :metadata => 
				{:error_description => "Required fields to create a Logger Account are missing.", 
					:details => WIKI_LOGGER}			
		end

end
