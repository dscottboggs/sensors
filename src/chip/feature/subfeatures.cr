require "./subfeature"
struct Sensors::Subfeatures < Array(Sensors::Chip::Feature::Subfeature)
  property feature : Sensors::Chip::Feature
  def initialize(under @feature)
    @size = 0
    @capacity = 0
    @buffer = Pointer(Subfeature).null
  end
  def self.all(under feature : Feature)
    all = new under: feature
    feature.each_subfeature { |sf| all << Subfeature.new sf, under: feature }
    all
  end
end