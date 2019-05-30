describe Sensors::Features do
  it "has some features" do
    chip = Sensors::Chips.all.first
    empty = true
    chip.each_feature { |feat| pp! feat.label; empty = false }
    empty.should be_false
  end
end
