# Used for namespacing
#
module PrimeMultiplicationGenerator
  # Class used for generating primes
  #
  class Prime
    # Defines a class level instance variable to hold primes
    # that have been generated. Class level variables are
    # not a good design choice because they are shared by
    # subclasses
    #
    @cached_prime_numbers = {}

    # Sets up Class level Attribute Accessor
    #
    class << self
      attr_accessor :cached_prime_numbers
    end

    # Generates nth prime number.
    # @param n [Integer]
    # @return [Integer]
    #
    def self.prep_nth_prime(n)
      # Raise an exception if input number is less than 1
      #
      raise PrimeMultiplicationGenerator::PrimeException.new(n) if n < 1

      # Return a cached value of the prime number if it exists
      #
      return self.cached_prime_numbers[n] unless self.cached_prime_numbers[n].nil?

      # Generates counter for last prime that was cached
      #
      prime_number_counter = self.cached_prime_count

      # Starts counting prime ahead of the last prime that was evaluated
      #
      start_number = self.prep_start_number

      # Calls support method to perform the actual operation
      #
      prep_nth_prime_support(n, prime_number_counter, start_number)
    end

    # Returns the cached value for prime numbers
    # @param n [Integer]
    # @return [Integer]
    #
    def self.prep_cached_prime(n)
      self.cached_prime_numbers[n]
    end

    # Reset cached prime numbers hash
    # @return [NIl]
    #
    def self.reset_cached_prime_numbers
      self.cached_prime_numbers = {}
    end

    private

    # Support method for generating primes
    # @param n [Integer]
    # @param prime_count [Integer]
    # @param start_number [Integer]
    # @return [Integer]
    #
    def self.prep_nth_prime_support(n, prime_count, start_number)
      # Sets variables for input parameters
      #
      current_num, prime_count_input = start_number, prime_count

      # Start loop for evaluating next available prime number starting from
      # start number
      #
      begin
        if is_prime?(current_num)
          prime_count_input += 1
          self.cached_prime_numbers[prime_count_input] = current_num
        end
        current_num += 1
      end while  prime_count_input < n

      # Returns the nth prime number in the cache
      #
      self.cached_prime_numbers[n]
    end

    # Evaluates the starting number for counting prime numbers
    #  @return [Integer]
    #
    def self.prep_start_number
      prime_number_counter = self.cached_prime_count
      prime_number_counter == 0 ? 2 : self.cached_prime_numbers[prime_number_counter] + 1
    end

    # Generates the count of cached prime numbers
    # @return [Integer]
    #
    def self.cached_prime_count
      self.cached_prime_numbers.keys.length
    end

    # Algorithm is to divide the input by all numbers starting from 2
    # till the square root of input number. If it is not divisible by any of these numbers, then
    # it is a prime number
    # @param n [Integer]
    # @return [TrueClass/FalseClass]
    #
    def self.is_prime?(n)
      # 2 is a prime number
      #
      return true if n == 2

      # return false if n is even or less than 2
      #
      return false if n % 2 == 0 || n < 2

      # Number will be divided by all numbers starting from 2 till the floored
      # value of sqrt of that number
      #
      max_limit = Math.sqrt(n)

      # return false if the input number is an exact square of another number
      #
      return false if max_limit % max_limit.to_i == 0

      # floor the maximum limit till which input number is to be divided
      #
      max_limit = max_limit.to_i

      (2..max_limit).each { |i| return false if n % i == 0 }

      # Returns true if the number is not divisible by any number in
      # the defined range
      #
      true
    end
  end
end
