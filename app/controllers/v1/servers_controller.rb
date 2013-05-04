class V1::ServersController < V1::ApplicationController

  def index
    expose Server.all
  end

  def show
    expose Server.find(params[:id])
  end

end
