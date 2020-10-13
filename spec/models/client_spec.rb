require "rails_helper"

RSpec.describe Client, type: :model do
  context "validations" do
    let(:client_division) { ClientDivision.create(name: "Some Name") }
    let(:address) { Address.create(address1: "1234 Test", address2: "Suite 1", city: "Denver", state: "CO", zip: 80202) }
    it "is not valid without a name" do
      client = Client.new(name: nil, sic: 12324, address_id: address.id,
                          client_division_id: client_division.id,
                          industry_group: 123,major_group: 1234,
                          description: "A test description")
      expect(client.valid?).to eq(false)
    end

    it "is valid with valid attributes" do
      client = Client.new(name: "Test Client", sic: 12324, address_id: address.id,
                          client_division_id: client_division.id,
                          industry_group: 123,major_group: 1234,
                          description: "A test description")
      expect(client.valid?).to eq(true)
    end

    it "is not valid without an sic" do
      client = Client.new(name: "Test Client", sic: nil, address_id: address.id,
                          client_division_id: client_division.id,
                          industry_group: 123,major_group: 1234,
                          description: "A test description")
      expect(client.valid?).to eq(false)
    end

    it "is not valid without an address" do
      client = Client.new(name: "Test Client", sic: 12324, address_id: nil,
                          client_division_id: client_division.id,
                          industry_group: 123,major_group: 1234,
                          description: "A test description")
      expect(client.valid?).to eq(false)
    end

    it "is not valid without a client division" do
      client = Client.new(name: "Test Client", sic: 12324, address_id: address.id,
                          client_division_id: nil,
                          industry_group: 123,major_group: 1234,
                          description: "A test description")
      expect(client.valid?).to eq(false)
    end

    it "is not valid without an industry group" do
      client = Client.new(name: "Test Client", sic: 12324, address_id: address.id,
                          client_division_id: client_division.id,
                          industry_group: nil, major_group: 1234,
                          description: "A test description")
      expect(client.valid?).to eq(false)
    end

    it "is not valid without a major group" do
      client = Client.new(name: "Test Client", sic: 12324, address_id: address.id,
                          client_division_id: client_division.id,
                          industry_group: 123, major_group: nil,
                          description: "A test description")
      expect(client.valid?).to eq(false)
    end

    it "is not valid without a description" do
      client = Client.new(name: "Test Client", sic: 12324, address_id: address.id,
                          client_division_id: client_division.id,
                          industry_group: 123, major_group: 1234,
                          description: nil)
      expect(client.valid?).to eq(false)
    end
  end
end
