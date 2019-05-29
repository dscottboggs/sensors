class FailedInitialization < Exception
  def initialize
    LibSensors.cleanup
    super "could not initialize libsensors with the default config files"
  end

  def initialize(config_file)
    LibSensors.cleanup
    super %[could not initialize libsensors with config file "#{config_file}"]
  end
end
