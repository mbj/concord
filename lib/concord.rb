require 'adamantium'
require 'equalizer'

# A mixin to define a composition
class Concord < Module
  include Adamantium::Flat, Equalizer.new(:names)

  # The maximum number of objects the hosting class is composed of
  MAX_NR_OF_OBJECTS = 3

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
    if names.length > MAX_NR_OF_OBJECTS
      raise "Composition of more than #{MAX_NR_OF_OBJECTS} objects is not allowed"
    end

    @names = names
    @module = Module.new
    define_initialize
    define_readers
    define_equalizer
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
    descendant.send(:include, @module)
  end

  # Define equalizer
  #
  # @param [Class|Module] descendant
  #
  # @return [undefined]
  #
  # @api private
  #
  def define_equalizer
    @module.send(:include, Equalizer.new(*@names))
  end

  # Define readers
  #
  # @param [Class|Module] descendant
  #
  # @return [undefined]
  #
  # @api private
  #
  def define_readers
    attribute_names = names
    @module.class_eval do
      attr_reader(*attribute_names)
      protected(*attribute_names)
    end
  end

  # Define initialize method
  #
  # @param [Class|Module] descendant
  #
  # @return [undefined]
  #
  # @api private
  #
  def define_initialize
    ivars, size = instance_variable_names, names.size
    @module.class_eval do
      define_method :initialize do |*args|
        args_size = args.size
        if args_size != size
          raise ArgumentError, "wrong number of arguments (#{args_size} for #{size})"
        end
        ivars.zip(args) { |ivar, arg| instance_variable_set(ivar, arg) }
      end
      private :initialize
    end
  end

  # Return instance variable names
  #
  # @return [String]
  #
  # @api private
  #
  def instance_variable_names
    names.map { |name| "@#{name}" }
  end

  # Mixin for public attribute readers
  class Public < self

    # Hook called when module is included
    #
    # @param [Class,Module] descendant
    #
    # @return [undefined]
    #
    # @api private
    #
    def included(descendant)
      super
      @names.each do |name|
        descendant.send(:public, name)
      end
    end
  end # Public
end # Concord
