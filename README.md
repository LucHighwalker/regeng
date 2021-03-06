# Regeng (WIP)

[![Gem Version](https://badge.fury.io/rb/regeng.svg)](https://badge.fury.io/rb/regeng)

Regeng or regular english, is a gem aimed to make regular expressions a bit more noob friendly.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'regeng'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install regeng

## Usage

```ruby
require 'regeng'
=> true
Regeng.new 'any characters except e through z at start of string'
=> /\A[^e-z]+/
```

More examples in the [Documentation](https://luchighwalker.github.io/regeng/#/?id=usage)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/LucHighwalker/regeng.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
