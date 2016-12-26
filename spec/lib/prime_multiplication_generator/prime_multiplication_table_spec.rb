require_relative '../../spec_helper'
require 'colorize'

describe PrimeMultiplicationGenerator::PrimeMultiplicationTable do

  subject { PrimeMultiplicationGenerator::PrimeMultiplicationTable }

  EVEN_COLOR              =   PrimeMultiplicationGenerator::ColorSelections::EVEN_COLOR
  ODD_COLOR               =   PrimeMultiplicationGenerator::ColorSelections::ODD_COLOR
  BOUNDARY_PRIME_COLOR    =   PrimeMultiplicationGenerator::ColorSelections::BOUNDARY_PRIME_COLOR
  DASH_COLOR              =   PrimeMultiplicationGenerator::ColorSelections::DASH_COLOR

  describe '#prep_dash_str' do

    let(:n) { 10 }
    let(:prime_num_hash) {
      {
          1 => 1, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13, 7 => 17, 8 => 19, 9 => 23, 10 => 29
      }
    }
    let(:prime_table_obj) { subject.new(n, prime_num_hash) }
    let(:str) { 'Display' }

    it 'expects display_product_num to receive product and colorize to receive color hash' do
      expect(str).to receive(:colorize).exactly(1).times.with(DASH_COLOR)
      prime_table_obj.send(:prep_dash_str, str)
    end
  end

  describe '#prep_prime_num_str' do

    let(:n) { 10 }
    let(:prime_num_hash) {
      {
          1 => 1, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13, 7 => 17, 8 => 19, 9 => 23, 10 => 29
      }
    }
    let(:prime_table_obj) { subject.new(n, prime_num_hash) }
    let(:prime_num) { prime_num_hash[prime_num_hash.keys.length] }
    let(:color_hash) { BOUNDARY_PRIME_COLOR }
    let(:str) { 'Display   ' }

    before do
      allow(prime_table_obj).to receive(:display_prime_num).and_return str
    end

    it 'expects display_product_num to receive product and colorize to receive color hash' do
      expect(prime_table_obj).to receive(:display_prime_num).exactly(1).times.with(prime_num)
      expect(str).to receive(:colorize).exactly(1).times.with(color_hash)
      prime_table_obj.send(:prep_prime_num_str, prime_num)
    end
  end

  describe '#prep_product_num_str' do

    let(:n) { 10 }
    let(:prime_num_hash) {
      {
          1 => 1, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13, 7 => 17, 8 => 19, 9 => 23, 10 => 29
      }
    }
    let(:prime_table_obj) { subject.new(n, prime_num_hash) }
    let(:product) { prime_num_hash[prime_num_hash.keys.length] * prime_num_hash[prime_num_hash.keys.length] }
    let(:color_hash) { BOUNDARY_PRIME_COLOR }
    let(:str) { 'Display   ' }

    before do
      allow(prime_table_obj).to receive(:display_product_num).and_return str
    end

    it 'expects display_product_num to receive product and colorize to receive color hash' do
      expect(prime_table_obj).to receive(:display_product_num).exactly(1).times.with(product)
      expect(str).to receive(:colorize).exactly(1).times.with(color_hash)
      prime_table_obj.send(:prep_product_num_str, product, color_hash)
    end
  end

  describe '#prep_header_border' do

    let(:tab_count) { 6 }
    let(:n) { 10 }
    let(:prime_num_hash) {
      {
          1 => 1, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13, 7 => 17, 8 => 19, 9 => 23, 10 => 29
      }
    }
    let(:prime_table_obj) { subject.new(n, prime_num_hash) }
    let(:no_of_chars) { (tab_count + 1 ) * 8 }
    let(:dash_str) {
      str = ''
      (1..no_of_chars).each { str += '-' }
      str
    }
    let(:dash_formatted_str) { prime_table_obj.send(:prep_dash_str, dash_str) }

    context 'when tab count is given' do

      it 'calls puts with the correct string' do
        expect { prime_table_obj.send(:prep_header_border, tab_count) }.to output(dash_formatted_str + "\n").to_stdout
      end
    end
  end

  describe '#prep_max_prime_digit' do

    let(:n) { 10 }
    let(:prime_num_hash) {
      {
          1 => 1, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13, 7 => 17, 8 => 19, 9 => 23, 10 => 29
      }
    }
    let(:prime) { prime_num_hash[prime_num_hash.keys.length] }
    let(:max_digit) { Math.log10(prime).to_i + 1 }
    let(:prime_table_obj) { subject.new(n, prime_num_hash) }

    context 'when prime is two digits' do

      it 'displays the max digits for prime' do
        resp = prime_table_obj.send(:prep_max_prime_digit)
        expect(resp).to eq(max_digit)
      end
    end
  end

  describe '#prep_max_product_digit' do

    let(:n) { 10 }
    let(:prime_num_hash) {
      {
          1 => 1, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13, 7 => 17, 8 => 19, 9 => 23, 10 => 29
      }
    }
    let(:product) { prime_num_hash[prime_num_hash.keys.length] * prime_num_hash[prime_num_hash.keys.length] }
    let(:max_digit) { Math.log10(product).to_i + 1 }
    let(:prime_table_obj) { subject.new(n, prime_num_hash) }

    context 'when product is three digits' do

      it 'displays the max digits for product' do
        resp = prime_table_obj.send(:prep_max_product_digit)
        expect(resp).to eq(max_digit)
      end
    end
  end

  describe '#display_prime_num' do

    let(:n) { 10 }
    let(:prime_num_hash) {
      {
          1 => 1, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13, 7=> 17, 8 => 19, 9 => 23, 10 => 29
      }
    }
    let(:prime) { prime_num_hash[prime_num_hash.keys.length] }
    let(:prime_table_obj) { subject.new(n, prime_num_hash) }
    let(:max_prime_digit) { prime_table_obj.send(:prep_max_prime_digit) }
    let(:expected_resp) { "#{prime.to_s.rjust(max_prime_digit)}" }

    context 'when prime is two digits' do

      it 'displays the prime right justified to max prime digit' do
        resp = prime_table_obj.send(:display_prime_num, prime)
        expect(resp).to eq(expected_resp)
      end
    end
  end

  describe '#display_product_num' do

    let(:n) { 10 }
    let(:prime_num_hash) {
      {
          1 => 1, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13, 7=> 17, 8 => 19, 9 => 23, 10 => 29
      }
    }
    let(:product) { prime_num_hash[prime_num_hash.keys.length] * prime_num_hash[prime_num_hash.keys.length] }
    let(:prime_table_obj) { subject.new(n, prime_num_hash) }
    let(:max_product_digit) { prime_table_obj.send(:prep_max_product_digit) }
    let(:expected_resp) { "#{product.to_s.rjust(max_product_digit)}" }

    context 'when product is three digits' do

      it 'displays the product right justified to max product digit' do
        resp = prime_table_obj.send(:display_product_num, product)
        expect(resp).to eq(expected_resp)
      end
    end
  end

  describe '#prep_color' do

    context 'when n is odd' do

      let(:n) { 7 }
      let(:prime_num_hash) {
        {
            1 => 1, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13, 7=> 17
        }
      }
      let(:prime_table_obj) { subject.new(n, prime_num_hash) }

      it 'returns odd color' do
        resp = prime_table_obj.send(:prep_color, n)
        expect(resp).to eq(ODD_COLOR)
      end
    end

    context 'when n is even' do

      let(:n) { 6 }
      let(:prime_num_hash) {
        {
            1 => 1, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13
        }
      }
      let(:prime_table_obj) { subject.new(n, prime_num_hash) }

      it 'returns even color' do
        resp = prime_table_obj.send(:prep_color, n)
        expect(resp).to eq(EVEN_COLOR)
      end
    end
  end

  describe '#is_even?' do

    context 'when n is odd' do

      let(:n) { 7 }
      let(:prime_num_hash) {
        {
            1 => 1, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13, 7=> 17
        }
      }
      let(:prime_table_obj) { subject.new(n, prime_num_hash) }

      it 'returns true' do
        resp = prime_table_obj.send(:is_even?, n)
        expect(resp).to be_falsey
      end
    end

    context 'when n is even' do

      let(:n) { 6 }
      let(:prime_num_hash) {
        {
            1 => 1, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13
        }
      }
      let(:prime_table_obj) { subject.new(n, prime_num_hash) }

      it 'returns true' do
        resp = prime_table_obj.send(:is_even?, n)
        expect(resp).to be_truthy
      end
    end
  end
end