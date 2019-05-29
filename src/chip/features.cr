struct Sensors::Features < Array(Feature)
  property chip : Chip

  # From [the definition for Array](https://github.com/crystal-lang/crystal/blob/639e4765f3f4137f90c5b7da24d8ccb5b0bfec35/src/array.cr#L59)
  def initialize(on @chip)
    @size = 0
    @capacity = 0
    @buffer = Pointer(Feature).null
  end

  # All features on the given chip
  def self.all(chip : Chip)
    all_features = Features.new on: chip
    chip.each_feature { |feature| all_features << feature }
    all_features
  end
end
