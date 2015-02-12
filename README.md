# SafeTimeout

A safer alternative to Ruby's Timeout that uses unix processes instead of threads

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'safe_timeout'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install safe_timeout

## Usage

SafeTimeout is a drop-in replacement for Ruby's Timeout.

    SafeTimeout.timeout(2) do
      # Something that may take a while
      # Possible Timeout::Error raised
    end

or

    SafeTimeout.timeout(10, CustomTimeoutError) do
      # Something that may take a while
      # Possible CustomTimeoutError raised
    end

If one wishes this to be even more of a drop-in replacement one
could add the following to the top of an application:

    Timeout = SafeTimeout

## Contributing

1. Fork it ( https://github.com/[my-github-username]/safe_timeout/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
