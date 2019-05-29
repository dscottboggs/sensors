struct Sensors::Chips < Array(Chip)
  def self.all
    all_chips = Array(Chip).new
    Chips.each do |chip|
      all_chips << chip
    end
    new all_chips
  end

  def self.matching(match : Chip)
    selected_chips = Array(Chip).new
    Chips.each(match) { |chip| selected_chips << chip }
    new selected_chips
  end

  def self.each_with_index(match : ChipName, &block : ChipName -> _) : Void
    index = pointerof(0)
    while this_one = LibSensors.detected_chips match, index
      yield index.value, ChipName.new this_one
    end
  end

  def self.each_with_index(&block : ChipName -> _) : Void
    index = pointerof(0)
    while this_one = LibSensors.detected_chips Pointer(LibSensors::ChipName).null, index
      yield index.value, ChipName.new this_one
    end
  end

  def self.each(match : ChipName) : Void
    each_chip_with_index(match) { |_, chip| yield chip }
  end

  def self.each : Void
    each_chip_with_index { |_, chip| yield chip }
  end
end
