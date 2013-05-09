require 'spec_helper'

describe Job do
  
  describe "'Submit' a job" do

	  it "should return a friendly message if no servers are available" do
	  	job = build(:job)
      expect { job.submit }.to raise_error ApiExceptions::ServerNotAvailableError, 
	      'Requested server for apex and salesforce.com is not available.'	  	
	  end

	  it "should return a friendly message if a duplicate account exists" do
	  	server = create(:server)
	  	job = build(:job)
	  	original_job_id = job.job_id
	  	logger_account = create(:logger_account_jeffdonthemic)
	  	logger_system = build(:logger_system)

      VCR.use_cassette "models/job/duplicate_account" do
	      expect { job.submit }.to raise_error ApiExceptions::ProcessError
      end
	  end	  

	  it "should successfully submit a job for processing" do
	  	server = create(:server)
	  	job = build(:job)
	  	original_job_id = job.job_id
	  	logger_account = create(:logger_account_jeffdonthemictest1)
	  	logger_system = build(:logger_system)

      VCR.use_cassette "models/job/submit_success" do
        job.submit
      end

      job.papertrail_system.should_not be_nil
      job.status.should == 'in progress'
      job.starttime.should_not be_nil
      job.id.should_not be_nil
      job.job_id.should == original_job_id
	  end	  

  end  

end
