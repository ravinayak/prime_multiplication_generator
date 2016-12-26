$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'prime_multiplication_generator'))

require 'colorize'
require 'prime_multiplication_generator/version'
require 'prime_multiplication_generator/parse_input'
require 'prime_multiplication_generator/prime'
require 'prime_multiplication_generator/prime_multiplication_table'
require 'prime_multiplication_generator/color_selections'
require 'benchmark'

module PrimeMultiplicationGenerator
  # Draws the multiplication table for prime numbers
  # @param num [Integer]
  # @return [NIL]
  #
  def self.generate_prime_table(input_no_of_primes = nil)
    no_of_primes = ParseInput.parse_input(input_no_of_primes)
    Prime.prep_nth_prime(no_of_primes)
    prime_mult_table = PrimeMultiplicationTable.new(no_of_primes, Prime.cached_prime_numbers)
    prime_mult_table.display_table
    nil
  end

  # Generates benchmark tests
  #
  def self.benchmark_performance
    ::Benchmark.bm_primes
    nil
  end
end
