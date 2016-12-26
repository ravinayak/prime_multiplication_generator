# Used for namespacing
#
module PrimeMultiplicationGenerator
  # Class definition for exception
  #
  class PrimeException < StandardError

    # Defines a constant for message
    #
    EX_MSG = 'Input is in incorrect format. It must be a positive integer greater than 1'

    attr_reader :number, :msg

    def initialize(number, msg = nil)
      @number = number
      @msg = prep_msg(msg)
      @msg += ":: #{number}"
      super(@msg)
    end

    # Returns string message based on given input
    # @param msg [String]
    # @return [String]
    #
    def prep_msg(msg)
      return msg unless msg.nil?
      EX_MSG
    end
  end
end
