require 'prime_multiplication_generator/prime_exception'
# Used for namespacing
#
module PrimeMultiplicationGenerator
  # Includes class level methods for parsing input
  #
  module ParseInput
    # RegEx for Integer
    #
    INTEGER_REG_EX = /^[-+]?[1-9]([0-9]*)?$/

    # Constant for Default Size
    #
    DEFAULT_MULT_TABLE_SIZE = 10

    # Class level method for parsing input
    # @param num [Integer]
    #
    def self.parse_input(input_no_of_primes)
      return DEFAULT_MULT_TABLE_SIZE if input_no_of_primes.nil?
      raise PrimeException.new(input_no_of_primes) unless input_no_of_primes.to_s =~ INTEGER_REG_EX
      input_no_of_primes.to_i
    end
  end
end
