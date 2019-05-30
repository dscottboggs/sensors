class Sensors::Chip
  @name : Pointer(LibSensors::ChipName)

  def initialize(@name)
  end

  def self.parse(orig_name : String)
    parse orig_name.to_slice.to_unsafe
  end

  def self.parse(orig_name : LibC::Char*)
    retval = LibSensors.parse_chip_name orig_name, out result
    if retval != 0
      raise "Failed to parse chip name #{orig_name} -- sensors_parse_chip_name() returned #{retval}"
    end
    new name: result
  end

  getter features : Features { Features.all on: self }

  def to_unsafe
    @name
  end

  def finalize
    LibSensors.free_chip_name @name.value
    LibC.free self
  end

  def each_feature_with_index
    index = Pointer(LibC::Int).malloc size: 1, value: 0
    while feature = LibSensors.features self, index
      yield index.value, Feature.new feature, self
    end
  end

  def each_feature
    each_feature_with_index { |_, feat| yield feat }
  end

  # Accessors for C struct values

  {% for cstr in [:prefix, :path] %}
  def {{cstr.id}}
    String.new @name.value.{{cstr.id}}
  end
  {% end %}
  delegate :bus, :addr, to: @name.value
end
