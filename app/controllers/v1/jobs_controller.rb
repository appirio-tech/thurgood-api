class V1::JobsController < V1::ApplicationController
	jsonp	

	def index
	 expose Job.order("created_at DESC").all
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
		job = Job.find_by_job_id(params[:id])
		expose job if job
		error! :not_found, :metadata => {:details => WIKI_JOB} if !job
	end

	def by_email
		expose Job.by_email(params[:email])
	end

	def submit
		job = Job.find_by_job_id(params[:id])
		server = Server.available(job.language, job.platform)
		error! :server_unavailable, 
			:metadata => {:error_description => "Requested server type (#{job.language} & #{job.platform}) is not currently available", 
			:details => WIKI_JOB} unless server
		server.reserve
		expose server
	end

end
