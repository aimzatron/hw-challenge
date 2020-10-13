require "rails_helper"

RSpec.describe ClientsController do
  describe "GET count_all" do
    it "renders json and counts all clients" do
      address = Address.create(address1: "1234 Test Street", city: "Denver", state: "CO")
      client_division=  ClientDivision.create(name: "Some Name")
      Client.create(name: "Test Client", sic: 12324, address_id: address.id,
                    client_division_id: client_division.id, industry_group: 123,
                    major_group: 1234, description: "A test description")
      Client.create(name: "Another Test Client", sic: 12325, address_id: address.id,
                    client_division_id: client_division.id, industry_group: 125,
                    major_group: 1235, description: "A test description")
      get :count_all
      expect(response.body).to eq("2")
      expect(response).to have_http_status(:ok)
    end
  end
end
