describe Sensors::Subfeatures do
  it "is not empty" do
    feature = Sensors::Chips.all.first.features.first
    empty = true
    feature.each_subfeature do |subfeat|
      empty = false
      pp! subfeat.number, subfeat.value
    end
    empty.should be_false
  end
end
