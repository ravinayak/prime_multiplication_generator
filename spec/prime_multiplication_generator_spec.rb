require 'spec_helper'
require_relative '../lib/prime_multiplication_generator'

describe PrimeMultiplicationGenerator do

  subject { PrimeMultiplicationGenerator }

  it 'has a version number' do
    expect(PrimeMultiplicationGenerator::VERSION).not_to be nil
  end

  describe '.generate_prime_table' do

    let(:no_of_input) { 10 }

    it 'calls parse_input on ParseInput' do
      expect(PrimeMultiplicationGenerator::ParseInput).to receive(:parse_input).exactly(1)
                                                              .times.with(no_of_input).and_return no_of_input
      subject.generate_prime_table(no_of_input)
    end

    it 'calls prep_nth_prime on Prime' do
      expect(PrimeMultiplicationGenerator::Prime).to receive(:prep_nth_prime).exactly(1).times.with(no_of_input)
      subject.generate_prime_table(no_of_input)
    end

    it 'calls display_table on PrimeMultiplicationTable' do
      expect_any_instance_of(PrimeMultiplicationGenerator::PrimeMultiplicationTable)
          .to receive(:display_table).exactly(1).times
      subject.generate_prime_table(no_of_input)
    end

    it 'returns nil' do
      resp = subject.generate_prime_table(no_of_input)
      expect(resp).to be_nil
    end
  end

  describe '.benchmark_performance' do

    it 'calls bm_primes' do
      expect(::BenchmarkTest).to receive(:bm_primes).exactly(1).times
      subject.benchmark_performance
    end
  end
end