require "rails_helper"

RSpec.describe PoliciesController do
  describe "GET count_all" do
    let(:policy_division) { PolicyDivision.create(name: "Some Name") }
    let(:policy_type) { PolicyType.create(name: "A Policy Type") }
    let(:client_division) { ClientDivision.create(name: "Some Name") }
    let(:address) { Address.create(address1: "1234 Test", address2: "Suite 1",
                                   city: "Denver", state: "CO", zip: 80202) }
    let(:client) { Client.create(name: "Test Client", sic: 12324,
                              address_id: address.id,
                              client_division_id: client_division.id,
                              industry_group: 123,major_group: 1234,
                              description: "A test description") }

    let(:carrier) { Carrier.create(name: "Test Carrier", address_id: address.id) }

    it "renders json and counts all policies" do
      Policy.create(carrier_policy_number: 123, effective_date: DateTime.now,
                    expiration_date: DateTime.now, policy_type_id: policy_type.id,
                    policy_division_id: policy_division.id,  written_premium: 2300.0,
                    client: client, carrier: carrier)

      Policy.create(carrier_policy_number: 124, effective_date: DateTime.now,
                    expiration_date: DateTime.now, policy_type_id: policy_type.id,
                    policy_division_id: policy_division.id,  written_premium: 500.0,
                    client: client, carrier: carrier)

      get :count_all
      expect(response.body).to eq("2")
      expect(response).to have_http_status(:ok)
    end
  end
end
