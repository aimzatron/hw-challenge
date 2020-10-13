require "rails_helper"

RSpec.describe Carrier, type: :model do
  context "validations" do
    it "is not valid without a name" do
      expect(Carrier.new(name: nil).valid?).to eq(false)
    end

    it "is valid with a name" do
      expect(Carrier.new(name: "test").valid?).to eq(true)
    end
  end
end
