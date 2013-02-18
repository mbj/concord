require 'adamantium'
require 'equalizer'

# A mixin to define a composition
class Composition < Module
  include Adamantium::Flat, Equalizer.new(:names)

  # Return names
  #
  # @return [Enumerable<Symbol>]
  #
  # @api private
  #
  attr_reader :names

private

  # Initialize object
  #
  # @return [undefined]
  #
  # @api private
  #
  def initialize(*names)
    if names.length > 3
      raise 'Composition of more than three objects is not allowed'
    end

    @names = names
  end

  # Hook run when module is included
  #
  # @param [Class|Module] descendant
  #
  # @return [undefined]
  #
  # @api private
  #
  def included(descendant)
    define_initializer(descendant)
    define_readers(descendant)
    define_equalizer(descendant)
  end

  # Define equalizer
  #
  # @param [Class|Module] descendant
  #
  # @return [undefined]
  #
  # @api private
  #
  def define_equalizer(descendant)
    descendant.send(:include, Equalizer.new(*@names))
  end

  # Define readers
  #
  # @param [Class|Module] descendant
  #
  # @return [undefined]
  #
  # @api private
  #
  def define_readers(descendant)
    attribute_names = names
    descendant.send(:attr_reader, *attribute_names)
    descendant.send(:public, *attribute_names)
  end

  # Define initializer
  #
  # @param [Class|Module] descendant
  #
  # @return [undefined]
  #
  # @api private
  #
  def define_initializer(descendant)
    names = argument_names
    descendant.class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
      def initialize(#{names})                # def initialize(foo, bar)
        #{instance_variable_names} = #{names} #   @foo, @bar = foo, bar
      end                                     # end
    RUBY
  end

  # Return instance variable names
  #
  # @return [String]
  #
  # @api private
  #
  def instance_variable_names
    names.map { |name| "@#{name}" }.join(', ')
  end

  # Return param names
  #
  # @return [String]
  #
  # @api private
  #
  def argument_names
    names.join(', ')
  end

end
