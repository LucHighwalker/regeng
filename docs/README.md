# Regeng (WIP)

Regeng or regular english, is a gem aimed to make regular expressions a bit more noob friendly.

[Regeng Gem](https://rubygems.org/gems/regeng)

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

### Quick Start 

```ruby
require 'regeng'
=> true
Regeng.new 'any characters except e through z at start of string'
=> /\A[^e-z]+/
```

[Characters](/usage/characters.md ':include')

[Numbers](/usage/numbers.md ':include')

[AtModifier](/usage/atmodifier.md ':include')

[ExceptMod](/usage/exceptmod.md ':include')

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/LucHighwalker/regeng.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Changelog

[Changelog](/changelog.md ':include')
