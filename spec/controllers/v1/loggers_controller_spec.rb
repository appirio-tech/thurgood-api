require 'spec_helper'

describe V1::LoggersController do

  before(:all) do
  	create(:api_key)
  	@api_key = ApiKey.first.access_key
  end  	

	describe "'Create' account" do

		it "should return a new account with a specified papertrail_id" do
	  	name = 'somename'
	  	email = 'some@email.com'
	  	papertrail_id = 'someid'

	    request.env['Authorization'] = 'Token token="'+@api_key+'"'
	    VCR.use_cassette "controllers/v1/loggers_controller/create_success" do
		    post 'account_create', 
			    params = { :account => {:name => name, :email => email, :papertrail_id => papertrail_id }}		
		  end
			response.response_code.should == 200  
			results = JSON.parse(response.body)['response']
			results['name'].should == name
			results['email'].should == email
			results['papertrail_id'].should == papertrail_id
		end

		it "should return 400 and pretty message without the right fields" do
	    request.env['Authorization'] = 'Token token="'+@api_key+'"'
	    post 'account_create', 
		    params = { :account => {:name => 'somename' }} 
		  response.response_code.should == 400
		  results = JSON.parse(response.body)
		  results['error'].should == 'bad_request'
		  results['error_description'].should include("Error creating Logger Account")
		end

		it "should return 400 and pretty message without account params" do
	    request.env['Authorization'] = 'Token token="'+@api_key+'"'
	    post 'account_create', 
		    params = {:bad_param => 'bad param' }
		  response.response_code.should == 400
		  results = JSON.parse(response.body)
		  results['error'].should == 'bad_request'
		  results['error_description'].should == "Required fields to create a Logger Account are missing."
		end		
	end		

	describe "'Create' system" do

		it "should return a new system" do

	  	account = create(:logger_account)
	  	account.papertrail_id = "#{account.name}#{Random.rand(99)}"
      VCR.use_cassette "models/logger_account/create_success" do
        account = account.setup
        account.save
      end

			papertrail_account_id = account.papertrail_id
			logger_account_id = account.id

	    request.env['Authorization'] = 'Token token="'+@api_key+'"'
	    VCR.use_cassette "controllers/v1/loggers_controller/create_system_success" do
		    post 'system_create', 
			    params = { :system => {:name => logger_account_id, :papertrail_account_id => papertrail_account_id, 
			    	:papertrail_id => logger_account_id, :logger_account_id => logger_account_id }}		
		  end
		  
		  response.response_code.should == 200
		  results = JSON.parse(response.body)['response']
		  results['syslog_hostname'].should_not be_nil
		  results['syslog_port'].should_not be_nil

		end

	end			

end
