require 'spec_helper'

describe V1::JobsController do

	describe "'Create' Job" do

		it "should return a friendly error message when bad fields are passed" do
			post 'create', params = { :job => {:bad_field => 'foo' }}
			response.response_code.should == 400
			results = JSON.parse(response.body)
			results['error'].should == 'bad_request'
		end

		it "should return a friendly error message when the job hash is not passed" do
			post 'create', params = { :bad_field => 'foo' }
			response.response_code.should == 400
			results = JSON.parse(response.body)
			results['error'].should == 'bad_request'
		end		

		it "should return a friendly error message when some fields are missing" do
			post 'create', params = { :job => {:email => 'some@email.com', :user_id => 'cmc-1234'} }
			response.response_code.should == 400
			results = JSON.parse(response.body)
			results['error'].should == 'bad_request'
			results['error_description'].should == "Language can't be blank, Platform can't be blank"
		end		

		it "should create a job successfully" do
			user_id = 'cs-12344'
			email = 'some@email.com'
			language = 'apex'
			platform = 'salesforce.com'
			post 'create', params = { :job => {:user_id => user_id, :email => email, 
				:language => language, :platform => platform} }
			response.response_code.should == 200
			results = JSON.parse(response.body)['response']
			results['job_id'].should_not be_nil
			results['language'].should == language
			results['platform'].should == platform
			results['email'].should == email
			results['status'].should == 'created'
		end			

	end
end
