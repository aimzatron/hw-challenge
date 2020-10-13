class CarriersController < ApplicationController
  def count_all
    @count = Carrier.count
    render json: @count.to_json, status: :ok
  end
end
