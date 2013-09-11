class V1::ApplicationController < RocketPants::Base

  before_filter :restrict_access, :except => [:info]

  WIKI_LOGGER = 'https://github.com/cloudspokes/thurgood-api/wiki/Logger'
  WIKI_JOB = 'https://github.com/cloudspokes/thurgood-api/wiki/Job'

  # Checks for the api_key passed in the header. If the api_key
  # from the header is found in the local database then access
  # is granted to the route. If not, returns a 401.
  def restrict_access
    add_api_key_for_dev if Rails.env.development?
    authorized = ApiKey.exists?(access_key: api_key_from_header)
    error! :unauthenticated if !authorized
  end   

  private

    def add_api_key_for_dev
      request.env['Authorization'] = 'Token token="' + ApiKey.first.access_key + '"'
    end

    # parses the api_key from the Authorization request header:
    # request.env['Authorization'] = 'Token token="THIS-IS-MY-TOKEN"'
    def api_key_from_header
      token = nil
      if request.headers['Authorization']
        begin 
          token = request.headers['Authorization'].split('=').second.gsub('"','')
        rescue Exception => e
          logger.info "[FATAL] Exception parsing header api token: #{e.message}"
        end
      end
      logger.fatal "[FATAL] No API Token passed." unless token
      token
    end  	

end
