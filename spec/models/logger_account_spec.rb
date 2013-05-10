require 'spec_helper'

describe LoggerAccount do

  describe "'Create' account" do
	  it "should return a friendly error if fields are missing" do
	  	account = LoggerAccount.new
      expect { account.setup }.to raise_error ApiExceptions::ProcessError
	  end

	  it "should successfully create a logger" do
	  	account = create(:logger_account)
	  	account.papertrail_id = "#{account.name}#{Random.rand(99)}"
      VCR.use_cassette "models/logger_account/create_success" do
        account = account.setup
        account.save
      end
      account.papertrail_api_token.should_not be_nil
      account.papertrail_id.should == account.papertrail_id

			# delete the newly created account now
      VCR.use_cassette "models/logger_account/delete_account_cleanup" do
        Papertrail.delete_account(account.papertrail_id)
      end			

	  end

  end  
end
