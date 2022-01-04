# SafeTimeout

* README:         https://github.com/david-mccullars/safe_timeout
* Documentation:  http://www.rubydoc.info/github/david-mccullars/safe_timeout
* Bug Reports:    https://github.com/david-mccullars/safe_timeout/issues


## Status

[![Gem Version](https://badge.fury.io/rb/safe_timeout.svg)](https://badge.fury.io/rb/safe_timeout)
[![Build Status](https://github.com/david-mccullars/safe_timeout/workflows/CI/badge.svg)](https://github.com/david-mccullars/safe_timeout/actions?workflow=CI)
[![Code Climate](https://codeclimate.com/github/david-mccullars/safe_timeout/badges/gpa.svg)](https://codeclimate.com/github/david-mccullars/safe_timeout)
[![Test Coverage](https://codeclimate.com/github/david-mccullars/safe_timeout/badges/coverage.svg)](https://codeclimate.com/github/david-mccullars/safe_timeout/coverage)
[![MIT License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)


## Description

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


## License

MIT. See the {file:LICENSE} file.
