require "./lib_sensors"
require "./errors/*"
require "./chips"
require "./chip/**"

# TODO: Write documentation for `Sensors`
module Sensors
  VERSION = "0.1.0"

  result = LibSensors.init Pointer(Int32).null
  raise FailedInitialization.new if result != 0

  # def self.new(config_location : String)
  #   new config_location.to_slice
  # end

  # def initialize(config_location : LibC::Char*)
  #   result = LibSensors.init config_location
  #   raise FailedInitialization.new config_location if result != 0
  # end

  def self.version
    String.new LibSensors.version
  end
end

at_exit { LibSensors.cleanup }
