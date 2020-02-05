#
# bool2str.rb
#
module Puppet::Parser::Functions
  newfunction(:stringify_undef, type: :rvalue, doc: <<-DOC
    Converts an undefined variable, or an empty string, to the
    string 'undef'.  When the variable is assigned a
    proper value, that value is returned.
    An Optional second represent the string undef will be translated to.
    If only one argument is given, it will be converted to a string containing 'undef'.
    *Examples:*
    stringify_undef(undef)            => 'undef'
    stringify_undef(undef, 'nill')    => 'nill'
    stringify_undef('')               => 'undef'
    stringify_undef('', 'nill')       => 'nill'
    stringify('real string')          => 'real string'
    stringify('real string', 'undef') => 'real string'
    Requires a single string or undefined variable as argument.

    This function is mainly used to convert undef to a string passing arguments
    to the jenkins puppet_helper groovy actions.
    DOC
             ) do |arguments|

    unless arguments.size == 1 || arguments.size == 2
      raise(Puppet::ParseError, "bool2str(): Wrong number of arguments given (#{arguments.size} for 2)")
    end

    value = arguments[0]
    undef_string = arguments[1] || 'undef'
    klass = value.class

    # We can have either undef or a String, and nothing else
    # puppet does translate the undef to an empty string
    if value.nil? || value == :undef || (klass == String && value == '')
      value = undef_string
    end

    unless undef_string.is_a?(String)
      raise(Puppet::ParseError, 'stringify_undef(): Requires a strings to convert to as second argument')
    end

    return value
  end
end
