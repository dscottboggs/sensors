require "../src/sensors"

Sensors::Chips.each do |chip|
  if chip.prefix == "coretemp"
    chip.each_feature do |feature|
      puts "#{feature.label}: #{feature.subfeatures.first.value}"
    end
  end
end
