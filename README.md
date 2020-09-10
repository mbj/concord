concord
=======

[![Gem Version](http://img.shields.io/gem/v/concord.svg)][https://rubygems.org/gems/concord]
![CI](https://github.com/mbj/concord/workflows/CI/badge.svg)

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

You can still add YARD docs for generated interface.

Rubies
------

Tested under all >= 1.9 rubies.

Installation
------------

Install the gem `concord` via your preferred method.

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
