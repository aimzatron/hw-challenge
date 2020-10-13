require "rails_helper"

RSpec.describe Policy, type: :model do
  context "validations" do
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

    it "is not valid without a carrier_policy_number" do
      policy = Policy.new(carrier_policy_number: nil, effective_date: DateTime.now,
                              expiration_date: DateTime.now, policy_type_id: policy_type.id,
                              policy_division_id: policy_division.id,  written_premium: 2300.0,
                              client: client, carrier: carrier)
      expect(policy.valid?).to eq(false)
    end

    it "is valid with valid attributes" do
      policy = Policy.new(carrier_policy_number: 123, effective_date: DateTime.now,
                              expiration_date: DateTime.now, policy_type_id: policy_type.id,
                              policy_division_id: policy_division.id,  written_premium: 2300.0,
                              client: client, carrier: carrier)
      expect(policy.valid?).to eq(true)
    end

    it "is not valid without an effective_date" do
      policy = Policy.new(carrier_policy_number: 123, effective_date: nil,
                              expiration_date: DateTime.now, policy_type_id: policy_type.id,
                              policy_division_id: policy_division.id,  written_premium: 2300.0,
                              client: client, carrier: carrier)
      expect(policy.valid?).to eq(false)
    end

    it "is not valid without an expiration_date" do
      policy = Policy.new(carrier_policy_number: 123, effective_date: DateTime.now,
                              expiration_date: nil, policy_type_id: policy_type.id,
                              policy_division_id: policy_division.id,  written_premium: 2300.0,
                              client: client, carrier: carrier)
      expect(policy.valid?).to eq(false)
    end

    it "is not valid without a policy type" do
      policy = Policy.new(carrier_policy_number: 123, effective_date: DateTime.now,
                              expiration_date: DateTime.now, policy_type_id: nil,
                              policy_division_id: policy_division.id,  written_premium: 2300.0,
                              client: client, carrier: carrier)
      expect(policy.valid?).to eq(false)
    end

    it "is not valid without a policy division" do
      policy = Policy.new(carrier_policy_number: 123, effective_date: DateTime.now,
                              expiration_date: DateTime.now, policy_type_id: policy_type.id,
                              policy_division_id: nil,  written_premium: 2300.0,
                              client: client, carrier: carrier)
      expect(policy.valid?).to eq(false)
    end

    it "is not valid without a written premium" do
      policy = Policy.new(carrier_policy_number: 123, effective_date: DateTime.now,
                              expiration_date: DateTime.now, policy_type_id: policy_type.id,
                              policy_division_id: policy_division.id,  written_premium: nil,
                              client: client, carrier: carrier)
      expect(policy.valid?).to eq(false)
    end
  end
end
