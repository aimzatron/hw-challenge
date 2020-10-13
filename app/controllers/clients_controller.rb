class ClientsController < ApplicationController
  def count_all
    @count = Client.count
    render json: @count.to_json, status: :ok
  end

  def index
    @clients = Client.all.paginate(page: params[:page], per_page: 30)
    render json: @clients, status: :ok
  end
end
