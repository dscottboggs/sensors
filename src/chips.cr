require "./chip"

module Sensors
  class Chips < Array(Chip)
    def self.all
      all_chips = new
      Chips.each do |chip|
        all_chips << chip
      end
      all_chips
    end

    def self.matching(match : Chip)
      selected_chips = Array(Chip).new
      each match { |chip| selected_chips << chip }
      new selected_chips
    end

    def self.each_with_index(match : Chip, &block : Int32, Chip -> _) : Void
      index = Pointer(LibC::Int).malloc size: 1, value: 0
      while this_one = LibSensors.detected_chips match, index
        yield index.value, Chip.new this_one
      end
    end

    def self.each_with_index(&block : Int32, Chip -> _) : Void
      index = Pointer(LibC::Int).malloc size: 1, value: 0
      while this_one = LibSensors.detected_chips Pointer(LibSensors::ChipName).null, index
        yield index.value, Chip.new this_one
      end
    end

    def self.each(match : Chip, &block : Chip -> _) : Void
      each_with_index(match) { |_, chip| yield chip }
    end

    def self.each(&block : Chip -> _) : Void
      each_with_index { |_, chip| yield chip }
    end
  end
end
