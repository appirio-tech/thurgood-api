require 'spec_helper'

describe LoggerAccount do

  describe "'Create' account" do
	  it "should return a friendly error if fields are missing" do
	  	account = LoggerAccount.new
      expect { account.setup }.to raise_error ApiExceptions::ProcessError
	  end

	  it "should return a friendly error if the pt account already exists" do
	  	account = build(:logger_account_jeffdonthemic)
	  	account.papertrail_id = account.name
      VCR.use_cassette "models/logger_account/create_existing" do
	      expect { account.setup }.to raise_error ApiExceptions::ProcessError, 
		      'The Logger Account already exists.'
      end	  	
	  end	  

	  it "should successfully create a logger" do
	  	account = build(:logger_account)
	  	account.papertrail_id = account.name
      VCR.use_cassette "models/logger_account/create_success" do
        account = account.setup
        account.save
      end
      account.papertrail_api_token.should_not be_nil
      account.papertrail_id.should == account.name

			# delete the newly created account now
      VCR.use_cassette "models/logger_account/delete_account" do
        Papertrail.delete_account(account.papertrail_id)
      end			

	  end

  end  
end
