class PoliciesController < ApplicationController
  def count_all
    @count = Policy.count
    render json: @count.to_json, status: :ok
  end

  def index
    @policies = Policy.all
    render json: @policies, status: :ok
  end
end
