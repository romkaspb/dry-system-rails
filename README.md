# Dry::System::Rails
Some magic stuff for autoload folders to dry-system in rails projects without pain. This gem is the fork from [dry-system-hanami](https://github.com/davydovanton/dry-system-hanami). Huge thanks to `dry-system-hanami` contributors.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dry-system-rails'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dry-system-rails

## Usage

### `lib_folder!`
By default, files will be looked in `app/` folder. If you don't want something like `transactions.user.create`,
you can specify another folder which deeper then `app`:

```ruby
require 'dry/system/container'

class Container < Dry::System::Container
  extend Dry::System::Rails::Resolver

  lib_folder! 'transactions'
  register_folder! 'user/operations'
  # or with custom resolver
  register_folder! 'user/schema', resolver: ->(k) { k }

  configure
end
```

This will generate `user.operations.create` instead of `transactions.user.operations.create`

### `register_folder!`
You can register full folder to your container:

```ruby
require 'dry/system/container'

class Container < Dry::System::Container
  extend Dry::System::Rails::Resolver

  register_folder! 'user/operations'
  # or with custom resolver
  register_folder! 'user/schema', resolver: ->(k) { k }

  configure
end
```

### `register_file!`
You can register specific file to your container:

```ruby
require 'dry/system/container'

class Container < Dry::System::Container
  extend Dry::System::Rails::Resolver

  register_file! 'user/operations/create'
  # or with custom resolver
  register_file! 'user/schema/create', resolver: ->(k) { k }

  configure
end
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Dry::System::Rails project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/romkaspb/dry-system-rails/blob/master/CODE_OF_CONDUCT.md).
