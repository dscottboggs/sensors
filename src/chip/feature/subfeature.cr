require "../feature"

module Sensors
  class Chip
    struct Feature
      struct Subfeature
        @lib_subfeature : Pointer(LibSensors::Subfeature)
        property feature : Feature

        def initialize(@lib_subfeature, under @feature); end

        @[AlwaysInline]
        def to_unsafe
          @lib_subfeature
        end

        def name
          String.new @lib_subfeature.name
        end

        def value
          LibSensors.value feature.chip, number, out value
          value
        end

        def value=(input : LibC::Double)
          if (ret = LibSensors.set_value feature.chip, number, input) != 0
            raise "ERROR: sensors_set_value() returned #{ret}, meaning: #{String.new LibSensors.strerror ret}; while setting subfeature #{name} of feature #{feature.label} to #{input}"
          end
          if (ret = LibSensors.do_chip_sets feature.chip) != 0
            raise "ERROR: while setting subfeature #{name} of feature #{feature.label} to #{input}, sensors_do_chip_sets() returned #{ret}, meaning: #{String.new LibSensors.strerror ret}"
          end
        end

        delegate :number, :type, :mapping, :flags, to: @lib_subfeature.value
      end
    end
  end
end
