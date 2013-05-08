module Papertrail

	# id = membername, name = membername, email = email
  def self.create_account(id, name, email)
    # if a nil id is passed, use the name for the id
    id = name if !id    

  	auth = {
  		:username => ENV['PAPERTRAIL_DIST_USERNAME'], 
  		:password => ENV['PAPERTRAIL_DIST_PASSWORD']
  	}
  	
  	# create the user's account
  	user = {
  		:id => id, 
  		:email => email
  	}
  	payload = {
  		:id => id, 
  		:name => name, 
  		:user => user, 
  		:plan => 'free'
  	}
  	options = { 
  		:body => payload, 
  		:basic_auth => auth 
  	}

  	HTTParty.post("https://papertrailapp.com/api/v1/distributors/accounts", options)

  end

  # id = challenge_participant_id, name = "Challenge-#{challenge_id}-#{challenge_participant_id}", account_id = membername
  def self.create_system(id, name, account_id)

  	auth = {
  		:username => ENV['PAPERTRAIL_DIST_USERNAME'], 
  		:password => ENV['PAPERTRAIL_DIST_PASSWORD']
  	}

  	# create the system / log sender
  	payload = {
  		:id => id, 
  		:name => name, 
  		:account_id => account_id
  	}
  	options = { 
  		:body => payload, 
  		:basic_auth => auth 
  	}  	

  	HTTParty.post("https://papertrailapp.com/api/v1/distributors/systems", options)

  end  

end