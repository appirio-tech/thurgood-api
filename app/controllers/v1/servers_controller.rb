class V1::ServersController < V1::ApplicationController
	jsonp

  def index
    expose Server.all
  end

  def by_status
    expose Server.where("status = ?", params[:status])
  end  

  def show
    expose Server.find(params[:id])
  end

  def release
  	server = Server.find(params[:id])
  	server.status = 'available'
  	server.save
    expose server
  end  

end
