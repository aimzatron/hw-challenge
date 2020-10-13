require "rails_helper"

RSpec.describe PolicyType, type: :model do
  context "validations" do
    it "is valid with a name" do
      policy_type = PolicyType.new(name: "Test Policy Type")
      expect(policy_type.valid?).to eq(true)
    end

    it "is invalid without a name" do
      policy_type = PolicyType.new(name: nil)
      expect(policy_type.valid?).to eq(false)
    end
  end
end
