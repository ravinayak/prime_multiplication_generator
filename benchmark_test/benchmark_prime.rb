require_relative '../lib/prime_multiplication_generator'
require 'benchmark/ips'
# Used for namespacing benchmark
#
module BenchmarkTest

  # Constant to hold Prime class
  #
  PRIME_CONST = ::PrimeMultiplicationGenerator::Prime

  # Class definition for benchmarking
  #
  class BenchmarkPrime
    # Test Data Constant
    #
    TEST_DATA = [10, 100, 1000]

    # Class method to perform benchmarking of prime number calculation for cache
    #
    def self.bm_prime_cache_calculation
      puts prep_str(prep_prime_cache_str)

      Benchmark.ips do |x|
        TEST_DATA.each do |test_data|
          self.no_cache(x, test_data)
          self.use_cache(x, test_data)
          x.compare!
        end
      end
    end

    # Class method to perform benchmarking of prime number checking
    #
    def self.bm_prime_check_calculation
      puts prep_str(prep_prime_check_str)

      Benchmark.ips do |x|
        TEST_DATA.each do |test_data|
          x.report("Prime No Check :: #{test_data}") do
            PRIME_CONST.reset_cached_prime_numbers
            PRIME_CONST.is_prime?(test_data)
          end
        end
      end
    end

    # Prepares string for display
    # @return [String]
    #
    def self.prep_prime_check_str
      '   Prints Prime Number Evaluation - '
    end

    # Prepares string for display
    # @return [String]
    #
    def self.prep_prime_cache_str
      str = '   Prints Comparison of Prime Number Calculation - '
      str += "\n\n\t\t a. When Cache NOT is used"
      str + "\n\t\t b. When Cache is used"
    end

    # Prepares basic string for display
    # @param word_str [String]
    # @return [String]
    #
    def self.prep_str(word_str)
      aster_str =
          '******************************************************************************************************'
      str = aster_str
      str += "\n\n"
      str += word_str
      str += "\n\n"
      str += aster_str
      str + "\n\n"
    end

    # No Cache version for benchmarking
    # @param x [Integer]
    # @param test_data [Array]
    #
    def self.no_cache(x, test_data)
      x.report("No Cache : #{test_data}") do
        PRIME_CONST.reset_cached_prime_numbers
        PRIME_CONST.prep_nth_prime(test_data)
      end
    end

    # Cache version for benchmarking
    # @param x [Integer]
    # @param test_data [Array]
    #
    def self.use_cache(x, test_data)
      PRIME_CONST.reset_cached_prime_numbers
      PRIME_CONST.prep_nth_prime(test_data)
      x.report("Use Cache : #{test_data}") { PRIME_CONST.prep_nth_prime(test_data) }
    end
  end
end
