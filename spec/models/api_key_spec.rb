require 'spec_helper'

describe ApiKey do

  it "should create a new apikey with token" do
  	create(:api_key)
  	key = ApiKey.first
  	key.access_key.should_not be_nil
  end 

end
