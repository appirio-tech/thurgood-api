require 'spec_helper'

describe Job do
  
  describe "'Submit' a job" do

	  it "should successfully submit a job for processing" do
	  	job = build(:job)
	  	job.submit

	  end

  end  

end
