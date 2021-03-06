# Primes Multiplication Table

## Summary

This gem displays a multiplication table of N prime numbers to the console and provide a colorized output. It also
benchmarks performance of Prime Number determination, and calculation of Prime Numbers

![alt text][sample_output]

[sample_output]: https://github.com/ravinayak/prime_multiplication_generator/blob/master/images/SampleOutput.png

## Getting Started

To install gem, use the following line:

    $ Clone the directory - git clone git@github.com:ravinayak/prime_multiplication_generator.git
    $ cd into the directory => cd prime_multiplication_generator
    $ gem install prime_multiplication_generator-0.1.0.gem
    $ irb
    $ irb> require 'prime_multiplication_generator'
    $ irb> PrimeMultiplicationGenerator.generate_prime_table
    $ irb> PrimeMultiplicationGenerator.generate_prime_table(20)
    $ irb> PrimeMultiplicationGenerator.benchmark_performance

To add it to your Gemfile:

    $ gem 'prime_multiplication_generator', github: 'git@github.com:ravinayak/prime_multiplication_generator.git'

To use it in code:

    $ require 'prime_multiplication_generator'
    $ prime_table   =   PrimeMultiplicationGenerator.generate_prime_table (defaults to a size of 10)
                    =   PrimeMultiplicationGenerator.generate_prime_table(<<num>>)

## Performance

    Space complexity is O(N) => the program caches N prime numbers once they are calculated.
    Time complexity is O(m * sqrt(m)) for completely calculating N prime numbers where m is the
    Nth prime number.

## Benchmarking

    Benchmarking is provided as a support for this gem in code, it can be run as follows:

    $ require 'prime_multiplication_generator'
    $ prime_table   =   PrimeMultiplicationGenerator.benchmark_performance

Below is a snapshot of results of the benchmark tests:

![alt text][prime_benchmark_tests]

[prime_benchmark_tests]: https://github.com/ravinayak/prime_multiplication_generator/blob/master/images/BenchmarkPerformanceOutput.png
