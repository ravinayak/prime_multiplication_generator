# Used for namespacing
#
module PrimeMultiplicationGenerator
  # Class definition for exception
  #
  class PrimeException < StandardError

    # Defines a constant for message
    #
    EX_MSG = 'Prime Number cannot be computed for given input'

    attr_reader :number

    def initialize(number, msg = nil)
      @number = number
      msg += ":: #{number}" if msg.nil?
      super(msg)
    end
  end
end
