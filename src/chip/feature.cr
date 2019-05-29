require "./feature/subfeatures"

struct Sensors::Chip::Feature
  @lib_feature : Pointer(LibSensors::Feature)
  property chip : Chip

  def initialize(@lib_feature, on @chip); end

  getter subfeatures : Subfeatures do
    Subfeatures.all under: self
  end

  def subfeatures(&block : Subfeature -> R?) : Array(R) forall R
    data = Array(R).new
    each_subfeature do |subfeat|
      if result = yield subfeat
        data << result
      end
    end
    data
  end

  def []?(type : LibSensors::SubfeatureType) : Subfeature?
    if subfeat = LibSensors.subfeature(@chip, self, type)
      Subfeature.new subfeat, under: self
    end
  end

  def [](type : LibSensors::SubfeatureType) : Subfeature
    self[type]? || raise KeyError.new type
  end

  def label
    String.new LibSensors.label @chip, self
  end

  def each_subfeature_with_index
    index = pointerof(0)
    while subfeat = LibSensors.all_subfeatures @chip, self, index
      yield index.value, Subfeature.new subfeat, under: self
    end
  end

  def each_subfeature
    each_subfeature_with_index { |_, subfeat| yield subfeat }
  end

  @[AlwaysInline]
  def to_unsafe
    @lib_feature
  end
end
