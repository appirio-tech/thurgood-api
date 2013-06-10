module Papertrail

  def self.get_account(id)

    auth = {
      :username => ENV['PAPERTRAIL_DIST_USERNAME'], 
      :password => ENV['PAPERTRAIL_DIST_PASSWORD']
    }    
    options = { 
      :basic_auth => auth 
    }

    results = HTTParty.get("https://papertrailapp.com/api/v1/distributors/accounts/#{id}", options)
    Rails.logger.debug "[DEBUG][PT] Get Papertrail account: #{results.to_yaml}"
    results

  end

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

    Rails.logger.debug "[DEBUG][PT] Creating new Papertrail account with opions: #{options}"
  	results = HTTParty.post("https://papertrailapp.com/api/v1/distributors/accounts", options)
    Rails.logger.debug "[DEBUG][PT] New Papertrail account: #{results.to_yaml}"
    results

  end

  def self.delete_account(id)

    auth = {
      :username => ENV['PAPERTRAIL_DIST_USERNAME'], 
      :password => ENV['PAPERTRAIL_DIST_PASSWORD']
    }

    options = { 
      :basic_auth => auth 
    }   

    Rails.logger.debug "[DEBUG][PT] Deleting Papertrail account #{id}"
    results = HTTParty.delete("https://papertrailapp.com/api/v1/distributors/accounts/#{id}", options)
    Rails.logger.debug "[DEBUG][PT] Papertrail account deleted: #{results.to_yaml}"
    results       

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

    Rails.logger.debug "[DEBUG][PT] Creating new Papertrail system with options: #{options}"
    results = HTTParty.post("https://papertrailapp.com/api/v1/distributors/systems", options)
    Rails.logger.debug "[DEBUG][PT] New Papertrail system: #{results.to_yaml}"
    results    

  end  

  def self.delete_system(id)

    auth = {
      :username => ENV['PAPERTRAIL_DIST_USERNAME'], 
      :password => ENV['PAPERTRAIL_DIST_PASSWORD']
    }

    options = { 
      :basic_auth => auth 
    }   

    Rails.logger.debug "[DEBUG][PT] Deleting Papertrail system with options: #{options}"
    results = HTTParty.delete("https://papertrailapp.com/api/v1/distributors/systems/#{id}", options)
    Rails.logger.debug "[DEBUG][PT] Papertrail system deleted: #{results.to_yaml}"
    results       

  end

  # runs throught all of the methods to ensure they are working
  def self.check_me

    id = 'cloudspokes-rake-check'
    email = "#{id}@cloudspokes.com"
    name = id
    system_id = 'test-system'
    
    # create the papertrail account
    account_create_results = self.create_account(id, name, email)
    Rails.logger.fatal "[FATAL] Error creating Papertrail account: #{account_create_results.to_yaml}" if account_create_results['id'] != id

    # get the account
    account = self.get_account(id)
    Rails.logger.fatal "[FATAL] Error fetching Papertrail account: #{account.to_yaml}" if account['id'] != id

    # create a system
    system = self.create_system(system_id, system_id, account['id'])
    Rails.logger.fatal "[FATAL] Error creating Papertrail system: #{system.to_yaml}" if system['id'] != system_id

    # delete the account
    delete_results = self.delete_account(id)

  end  

end