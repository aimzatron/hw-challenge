require "rails_helper"

RSpec.describe ClientDivision, type: :model do
  context "validations" do
    it "is valid with a name" do
      client_division = ClientDivision.new(name: "Test Client Division")
      expect(client_division.valid?).to eq(true)
    end

    it "is invalid without a name" do
      client_division = ClientDivision.new(name: nil)
      expect(client_division.valid?).to eq(false)
    end
  end
end
