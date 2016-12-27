require_relative '../benchmark_test/benchmark_prime'

# Used for namespacing
#
module BenchmarkTest
  # Benchmarks performance of prime number caching and check
  #
  def self.bm_primes
    BenchmarkPrime.bm_prime_cache_calculation
    BenchmarkPrime.bm_prime_check_calculation
  end
end
