require "rails_helper"

RSpec.describe PolicyDivision, type: :model do
  context "validations" do
    it "is valid with a name" do
      policy_division = PolicyDivision.new(name: "Test Policy Division")
      expect(policy_division.valid?).to eq(true)
    end

    it "is invalid without a name" do
      policy_division = PolicyDivision.new(name: nil)
      expect(policy_division.valid?).to eq(false)
    end
  end
end
