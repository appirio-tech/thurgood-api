class V1::ApplicationController < RocketPants::Base

	# before_filter :add_api_key # testing for dev
	before_filter :restrict_access

  WIKI_LOGGER = 'https://github.com/cloudspokes/thurgood-api/wiki/Logger'
  WIKI_JOB = 'https://github.com/cloudspokes/thurgood-api/wiki/Job'

  # Checks for the api_key passed in the header. If the api_key
  # from the header is found in the local database then access
  # is granted to the route. If not, returns a 401.
  def restrict_access
    authorized = ApiKey.exists?(access_key: api_key_from_header)
    error! :unauthenticated if !authorized
  end   

  private

  	# # this is only for ease of development
  	# def add_api_key
  	# 	request.env['Authorization'] = 'Token token="' + ApiKey.first.access_key + '"'
  	# end

    # parses the api_key from the Authorization request header:
    # request.env['Authorization'] = 'Token token="THIS-IS-MY-TOKEN"'
    def api_key_from_header
      token = nil
      if request.headers['Authorization']
        begin 
          puts "======1 : #{request.headers['Authorization'].split('=')}"
          puts "======2 : #{request.headers['Authorization'].split('=').second}"
          puts "======3 : #{request.headers['Authorization'].split('=')[1]}"
          puts "======3 : #{request.headers['Authorization'].split('=').second.gsub('"','')}"
          token = request.headers['Authorization'].split('=').second.gsub('"','')
        rescue Exception => e
          puts "exception: #{e.message}"
        end
      end
      puts "[FATAL]No API Token passed." unless token
      token
    end  	

end
