# TODO: Write documentation for `Sensors`
module Sensors
  VERSION = "0.1.0"

  def initialize
    result = LibSensors.init Pointer(LibC::FILE).null
    raise FailedInitialization.new if result != 0
  end

  def self.new(config_location : String)
    new config_location.to_slice
  end

  def initialize(config_location : LibC::Char*)
    result = LibSensors.init config_location
    raise FailedInitialization.new config_location if result != 0
  end

  def finalize
    LibSensors.cleanup
  end

  def self.version
    String.new LibSensors.version
  end
end

at_exit { LibSensors.cleanup }
