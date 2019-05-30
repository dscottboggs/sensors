# sensors

Iterate and access hardware sensors from your Crystal applications.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     sensors:
       github: dscottboggs/sensors
   ```

2. Run `shards install`

## Usage

```crystal
require "sensors"

Sensors::Chips.each do |chip|
  if chip.prefix == "coretemp"
    chip.each_feature do |feature|
      puts "#{feature.label}: #{feature.subfeatures.first.value}"
    end
  end
end
```

## Contributing

1. Fork it (<https://github.com/dscottboggs/sensors/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [D. Scott Boggs](https://github.com/dscottboggs) - creator and maintainer
