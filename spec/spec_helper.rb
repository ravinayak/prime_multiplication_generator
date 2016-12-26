GEM_ROOT = File.join(File.dirname(__FILE__), '../')

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(GEM_ROOT, 'lib/prime_multiplication_generator/**/*.rb')].each { |f| require f }
