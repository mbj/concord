composition
===========

[![Build Status](https://secure.travis-ci.org/mbj/composition.png?branch=master)](http://travis-ci.org/mbj/composition)
[![Dependency Status](https://gemnasium.com/mbj/composition.png)](https://gemnasium.com/mbj/composition)
[![Code Climate](https://codeclimate.com/github/mbj/composition.png)](https://codeclimate.com/github/mbj/composition)

Library to transform this:

```ruby
class ComposedObject
  include Equalizer.new(:foo, :bar)

  # Return foo
  # 
  # @return [Foo]
  #
  # @api private
  #
  attr_reader :foo

  # Return bar
  #
  # @return [Bar]
  #
  # @api private
  #
  attr_reader :bar

  # Initialize object
  #
  # @param [Foo] foo
  # @param [Bar] bar
  #
  # @return [undefined]
  #
  # @api private
  #
  def initialize(foo, bar)
    @foo, @bar = foo, bar
  end
end
```

Into shorter and easier to parse by eyes:

```ruby
class ComposedObject
  include Composition.new(:foo, :bar)
end
```

Sure the replacement is missing YARD docs, but IMHO it is better.

Installation
------------

There is no gem release so use the following git source in your Gemfile:

```
gem 'composition', :git => 'https://github.com/mbj/composition.git'
# :github => 'mbj/composition' if you prefer plaintext easy MITM ready protocol
```

Credits
-------

* [mbj](https://github.com/mbj/composition)

Contributing
-------------

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with Rakefile or version
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

License
-------

See LICENSE
