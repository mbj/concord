concord
=======

[![Build Status](https://secure.travis-ci.org/mbj/concord.png?branch=master)](http://travis-ci.org/mbj/concord)
[![Dependency Status](https://gemnasium.com/mbj/concord.png)](https://gemnasium.com/mbj/concord)
[![Code Climate](https://codeclimate.com/github/mbj/concord.png)](https://codeclimate.com/github/mbj/concord)

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
  protected :foo

  # Return bar
  #
  # @return [Bar]
  #
  # @api private
  #
  attr_reader :bar
  protected :bar

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
  include Concord.new(:foo, :bar)
end
```

Sure the replacement is missing YARD docs, but IMHO it is better.

Rubies
------

Tested under all >= 1.9 rubies.

Installation
------------

Install the gem `concord` via your prefered method.

Credits
-------

* [mbj](https://github.com/mbj)

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
