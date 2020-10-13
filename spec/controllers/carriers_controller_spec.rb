require "rails_helper"

RSpec.describe CarriersController do
  describe "GET count_all" do
    it "renders json and counts all carriers" do
      address = Address.create(address1: "1234 Test Street", city: "Denver", state: "CO")
      Carrier.create(name: "A Test Carrier", address_id: address.id)
      Carrier.create(name: "Another Test Carrier", address_id: address.id)
      get :count_all
      expect(response.body).to eq("2")
      expect(response).to have_http_status(:ok)
    end
  end
end
