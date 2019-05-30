require "./spec_helper"
describe Sensors::Chips do
  it "finds some chips" do
    all = Sensors::Chips.new
    Sensors::Chips.each do |chip|
      pp! chip.prefix
      all << chip
    end
    all.should_not be_nil
    all.empty?.should be_false
  end
end
