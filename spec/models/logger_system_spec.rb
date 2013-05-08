require 'spec_helper'

describe LoggerSystem do

  describe "'Create' system" do
	  it "should return a friendly error if fields are missing" do
	  	account = create(:account_with_unique_email)
	  	system = build(:logger_system)
      expect { system.setup }.to raise_error ApiExceptions::ProcessError, 
	      'Required fields to create a Logger System are missing.'
	  end

	  it "should return a friendly error if the pt account already exists" do
	  	account = build(:logger_account)
	  	account.papertrail_id = account.name
      VCR.use_cassette "models/logger_account/create_existing" do
	      expect { account.setup }.to raise_error ApiExceptions::ProcessError, 
		      'The Logger Account already exists.'
      end	  	
	  end	  

	  it "should return friendly message when account is not found" do
	  	account = build(:logger_account)
	  	account.papertrail_id = 'bad-username'
      VCR.use_cassette "models/logger_account/create_success" do
        account = account.setup
        account.save
      end
      system_logger = LoggerSystem.new :name => 'testsystem1', :papertrail_id => 'testsystem1',
      	:papertrail_account_id => account['papertrail_id'], :logger_account_id => account.id

      VCR.use_cassette "models/logger_system/account_not_found" do	
				expect { system_logger.setup }.to raise_error ApiExceptions::ProcessError, 
					'Account not found'      	
	    end
	  end

	  it "should create a system successfully" do
	  	account = build(:logger_account)
	  	account.papertrail_id = account.name
      VCR.use_cassette "models/logger_account/create_success" do
        account = account.setup
        account.save
      end
      system_logger = LoggerSystem.new :name => 'testsystem1', :papertrail_id => 'testsystem1',
      	:papertrail_account_id => account['papertrail_id'], :logger_account_id => account.id

      VCR.use_cassette "models/logger_system/create_success" do	
				system_logger.setup
				system_logger.save
	    end
	    system_logger.syslog_hostname.should_not be_nil
	    system_logger.syslog_port.should_not be_nil
	  end	  

  end  
end
