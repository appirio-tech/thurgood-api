class V1::JobsController < V1::ApplicationController
  jsonp	

  def index
    expose Job.order("created_at DESC").limit(25)
  end

  def create
    job = Job.new params[:job]
    if job.save
      expose job
    else
      raise job.errors.full_messages.join(', ')
    end
  rescue Exception => e
    error! :bad_request, 
    :metadata => {:error_description => e.message, 
    :details => WIKI_JOB}
  end

  def show
    job = Job.fetch(params[:id])
    expose job if job
    error! :not_found, :metadata => {:details => WIKI_JOB} if !job
  end

  def info
    job = Job.fetch(params[:id])
    if job
      logger = LoggerSystem.find(job.papertrail_system)
      account = LoggerAccount.find(logger.logger_account_id)
      job_info = {:job => job, 
        :account => account, 
        :logger => logger}
      expose job_info
    end
    error! :not_found, :metadata => {:details => WIKI_JOB} if !job
  end  

  def server
    expose Server.fetch(params[:id])
  end

  def logger_system
    job = Job.fetch(params[:id])
    expose LoggerSystem.fetch(job)
  end	

  def by_user
    expose Job.by_user_id(params[:user_id])
  end

  def submit
    job = Job.fetch(params[:id])
    job.submit(params[:options])
    expose job
  rescue Exception => e
    error! :server_error, :metadata => {:error_description => e.message}		
  end

  def resubmit
    job = Job.fetch(params[:id])
    job.resubmit
    expose job
  rescue Exception => e
    error! :server_error, :metadata => {:error_description => e.message}		
  end	

  def message
    job = Job.fetch(params[:id])
    job.send_to_logger(params[:message][:text], params[:message][:sender])
    expose 'true'
  rescue Exception => e
    error! :server_error, :metadata => {:error_description => e.message, :details => WIKI_LOGGER}		
  end		

  def complete
    job = Job.fetch(params[:id])
    job.status = 'complete'
    job.save
    server = Server.find_by_job_id(params[:id])
    if server
      server.release
      expose 'true'  
    end
  end	

end