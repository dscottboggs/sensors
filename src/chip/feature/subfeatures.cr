require "./subfeature"

module Sensors
  class Subfeatures < Array(Chip::Feature::Subfeature)
    property feature : Sensors::Chip::Feature

    def initialize(under @feature : Chip::Feature)
      @size = 0
      @capacity = 0
      @buffer = Pointer(Chip::Feature::Subfeature).null
    end

    def self.all(under feature : Chip::Feature)
      all = new under: feature
      feature.each_subfeature { |sf| all << sf }
      all
    end
  end
end
