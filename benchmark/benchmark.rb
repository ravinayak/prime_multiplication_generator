require_relative '../benchmark/benchmark_prime'

# Used for namespacing
#
module Benchmark
  # Benchmarks performance of prime number caching and check
  #
  def self.bm_primes
    BenchmarkPrime.bm_prime_cache_calculation
    BenchmarkPrime.bm_prime_check_calculation
  end
end
