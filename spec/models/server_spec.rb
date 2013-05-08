require 'spec_helper'

describe Server do
  
  describe "'All' servers" do
	  it "should return challenge that are open" do
	  	create(:server)
	  	servers = Server.all
	  	servers.count.should > 0
	  end
  end  

  pending "add spec for reserve server"

end
