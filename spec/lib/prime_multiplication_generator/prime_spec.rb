require_relative '../../spec_helper'

describe PrimeMultiplicationGenerator::Prime do

  subject { PrimeMultiplicationGenerator::Prime }

  describe '.prep_nth_prime' do

    context 'when n is less than 1' do

      let(:n_arr) { [-1, 0, -2] }

      it 'raises exception of kind PrimeException' do
        n_arr.each do |n|
          expect {
            subject.prep_nth_prime(n)
          }.to raise_exception do |ex|
            expect(ex).to be_kind_of(PrimeMultiplicationGenerator::PrimeException)
          end
        end
      end
    end

    context 'when cached primes includes a value for nth prime number' do

      let(:cached_primes) {
        {
            1 => 2, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13, 7 => 17
        }
      }
      let(:n) { 5 }

      before do
        subject.cached_prime_numbers = cached_primes
      end

      it 'does not call prep_nth_prime_support' do
        expect(subject).to_not receive(:prep_nth_prime_support)
        subject.prep_nth_prime(n)
      end
    end

    context 'when cached primes does NOT include a value for nth prime number' do

      let(:cached_primes) {
        {
            1 => 2, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13, 7 => 17
        }
      }
      let(:start_number) { cached_primes[cached_primes.keys.length] + 1 }
      let(:prime_count) { cached_primes.keys.length }
      let(:n) { 8 }

      it 'does call prep_nth_prime_support' do
        expect(subject).to receive(:prep_nth_prime_support).exactly(1).times.with(n, prime_count, start_number)
        subject.prep_nth_prime(n)
      end
    end
  end

  describe '.prep_nth_prime_support' do

    let(:prime_count) { 5 }
    let(:start_number) { 12 }
    let(:n) { 13 }
    let(:expected_cached_primes) {
      {
          6 => 13, 7 => 17, 8 => 19, 9 => 23, 10 => 29, 11 => 31, 12 => 37, 13 => 41
      }
    }

    it 'returns value for nth prime number' do
      resp = subject.prep_nth_prime_support(n, prime_count, start_number)
      expect(resp).to eq(expected_cached_primes[expected_cached_primes.keys.length + prime_count])
    end

    it 'fills cached primes with keys from starting number till nth number as key' do
      subject.cached_prime_numbers = { }
      subject.prep_nth_prime_support(n, prime_count, start_number)
      expect(subject.cached_prime_numbers).to eq(expected_cached_primes)
    end
  end

  describe '.reset_cached_prime_numbers' do

    let(:cached_primes) {
      {
          1 => 2, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13, 7 => 17
      }
    }
    let(:expected_val) { { } }

    before do
      subject.cached_prime_numbers = cached_primes
    end

    it 'resets cached primes' do
      subject.reset_cached_prime_numbers
      expect(subject.cached_prime_numbers).to eq(expected_val)
    end
  end

  describe '.prep_start_number' do

    context 'when cached primes is not empty' do

      let(:cached_primes) {
        {
            1 => 2, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13, 7 => 17
        }
      }
      let(:expected_prime) { cached_primes[cached_primes.keys.length] + 1 }

      before do
        subject.cached_prime_numbers = cached_primes
      end

      it 'returns start value after the last prime number' do
        resp = subject.prep_start_number
        expect(resp).to eq(expected_prime)
      end
    end

    context 'when cached primes is empty' do

      let(:cached_primes) { {} }
      let(:expected_prime) { 2 }

      before do
        subject.cached_prime_numbers = cached_primes
      end

      it 'returns start value of 2' do
        resp = subject.prep_start_number
        expect(resp).to eq(expected_prime)
      end
    end
  end

  describe '.cached_prime_count' do

    context 'when cached primes is not empty' do

      let(:cached_primes) {
        {
            1 => 2, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13, 7 => 17
        }
      }
      let(:expected_len) { cached_primes.keys.length }

      before do
        subject.cached_prime_numbers = cached_primes
      end

      it 'returns count of cached prime numbers' do
        resp = subject.cached_prime_count
        expect(resp).to eq(expected_len)
      end
    end

    context 'when cached primes is empty' do

      let(:cached_primes) { {} }
      let(:expected_len) { 0 }

      before do
        subject.cached_prime_numbers = cached_primes
      end

      it 'returns 0' do
        resp = subject.cached_prime_count
        expect(resp).to eq(expected_len)
      end
    end
  end

  describe '.is_prime?' do

    context 'when n is 2' do

      let(:n) { 2 }

      it 'returns true' do
        resp = subject.is_prime?(n)
        expect(resp).to be_truthy
      end
    end

    context 'when n is 1' do

      let(:n) { 1 }

      it 'returns false' do
        resp = subject.is_prime?(n)
        expect(resp).to be_falsey
      end
    end

    context 'when n is even' do

      let(:n_arr) { [4, 6, 8, 10] }

      it 'returns false' do
        n_arr.each do |n|
          resp = subject.is_prime?(n)
          expect(resp).to be_falsey
        end
      end
    end

    context 'when n is a perfect square' do

      let(:n_arr) { [25, 36, 121] }

      it 'returns false' do
        n_arr.each do |n|
          resp = subject.is_prime?(n)
          expect(resp).to be_falsey
        end
      end
    end

    context 'when n is a prime' do

      let(:n) { 17 }

      it 'returns true' do
        resp = subject.is_prime?(n)
        expect(resp).to be_truthy
      end
    end

    context 'when n is NOT prime' do

      let(:n) { 15 }

      it 'returns false' do
        resp = subject.is_prime?(n)
        expect(resp).to be_falsey
      end
    end
  end
end
