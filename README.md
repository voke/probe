# Probe

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'probe', github: 'voke/probe'

And then execute:

    $ bundle

## Usage

### Configuration

    Probe.configure do |config|
      config.api_key = '73ebff703106'
      config.endpoint = 'api.example.com/v1/notify'
      config.environment = ENV['RACK_ENV']
    end

### Send notification

    Probe.notify('onlinestore', 'clear_cache')

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
