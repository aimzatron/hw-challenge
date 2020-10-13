require "rails_helper"

RSpec.describe Address, type: :model do
  context "validations" do
    it "is valid with valid attributes" do
      address = Address.new(address1: "1234 Test Street",
                            city: "Denver",
                            state: "CO")
      expect(address.valid?).to eq(true)
    end

    it "is invalid without an address1" do
      address = Address.new(address1: nil,
                            city: "Denver",
                            state: "CO")
      expect(address.valid?).to eq(false)
    end

    it "is invalid without a city" do
      address = Address.new(address1: "1234 Test Street",
                            city: nil,
                            state: "CO")
      expect(address.valid?).to eq(false)
    end

    it "is invalid without a state" do
      address = Address.new(address1: "1234 Test Street",
                            city: "Denver",
                            state: nil)
      expect(address.valid?).to eq(false)
    end
  end
end
