require_relative '../../spec_helper'

describe PrimeMultiplicationGenerator::ParseInput do

  describe '.parse_input' do

    context 'when input_no_of_primes is nil' do

      let(:input_no_of_primes) { nil }

      it 'returns default table size' do
        resp = subject.parse_input(input_no_of_primes)
        expect(resp).to eq(subject::DEFAULT_MULT_TABLE_SIZE)
      end
    end

    context 'when input_no_of_primes is not a valid integer' do

      let(:input_no_of_primes) { 'Invalid' }

      it 'raises an exception' do
        expect {
          subject.parse_input(input_no_of_primes)
        }.to raise_exception do |ex|
          expect(ex).to be_kind_of(PrimeMultiplicationGenerator::PrimeException)
        end
      end
    end

    context 'when input_no_of_primes is a valid integer' do

      let(:input_no_of_primes) { 20 }

      it 'returns the input size' do
        resp = subject.parse_input(input_no_of_primes)
        expect(resp).to eq(input_no_of_primes)
      end
    end
  end
end
