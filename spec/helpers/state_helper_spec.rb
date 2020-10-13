require "rails_helper"

RSpec.describe StateHelper do
  context "state conversion" do
    it "converts a state name to an abbreviation correctly" do
      expect(StateHelper::STATE_NAME_TO_ABBR["Hawaii"]).to eq("HI")
    end
  end
end
