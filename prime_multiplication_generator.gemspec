# coding: utf-8

# Rubygems does the loading of path for you. Adjusting load paths
# is done mostly for dev purposes and is considered an
# Anti Pattern. However, to build it from github, the load path has
# to be managed, therefore bundler provides this by default
#

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

benchmark_test = File.expand_path('../benchmark_test', __FILE__)
$LOAD_PATH.unshift(benchmark_test) unless $LOAD_PATH.include?(benchmark_test)
#
require 'prime_multiplication_generator/version'

Gem::Specification.new do |spec|
  spec.name          = 'prime_multiplication_generator'
  spec.version       = PrimeMultiplicationGenerator::VERSION
  spec.authors       = ['ravinayak']
  spec.email         = ['ravinayak19@gmail.com']

  spec.summary       = %q{This gem prints a multiplication table of Prime numbers for a given input.}
  spec.homepage      = 'https://github.com/prime_multiplication_genrator'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://github.com'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'colorize', '~> 0.7'
  spec.add_dependency 'benchmark-ips', '~> 2.7'
  spec.add_dependency 'simplecov', '~> 0.12'
  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end