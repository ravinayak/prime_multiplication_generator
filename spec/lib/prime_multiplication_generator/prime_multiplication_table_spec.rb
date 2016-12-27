require_relative '../../spec_helper'
require 'colorize'

describe PrimeMultiplicationGenerator::PrimeMultiplicationTable do

  subject { PrimeMultiplicationGenerator::PrimeMultiplicationTable }

  EVEN_COLOR              =   PrimeMultiplicationGenerator::ColorSelections::EVEN_COLOR
  ODD_COLOR               =   PrimeMultiplicationGenerator::ColorSelections::ODD_COLOR
  BOUND_COLOR             =   PrimeMultiplicationGenerator::ColorSelections::BOUNDARY_PRIME_COLOR
  DASH_COLOR              =   PrimeMultiplicationGenerator::ColorSelections::DASH_COLOR


  describe '#display_table'do

    let(:n) { 10 }
    let(:prime_num_hash) {
      {
          1 => 2, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13, 7 => 17, 8 => 19, 9 => 23, 10 => 29
      }
    }
    let(:prime_table_obj) { subject.new(n, prime_num_hash) }
    let(:tab_count) { 12 }

    it 'calls prep_headers_tab_count' do
      expect(prime_table_obj).to receive(:prep_headers_tab_count).exactly(1).times.and_return tab_count
      prime_table_obj.display_table
    end

    it 'calls prep_headers_tab_count' do
      expect(prime_table_obj).to receive(:prep_header_border).exactly(1).times.with(tab_count)
      prime_table_obj.display_table
    end

    it 'calls prep_headers_tab_count' do
      expect(prime_table_obj).to receive(:prep_rows).exactly(1).times
      prime_table_obj.display_table
    end
  end


  #################################################################################

                ######      PRIVATE METHODS       ######

  #################################################################################

  describe '#prep_rows' do

    let(:n) { 10 }
    let(:prime_num_hash) {
      {
          1 => 2, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13, 7 => 17, 8 => 19, 9 => 23, 10 => 29
      }
    }
    let(:prime_table_obj) { subject.new(n, prime_num_hash) }

    it 'calls prep_row_str' do
      expect(prime_table_obj).to receive(:prep_row_str).exactly(n).times
      prime_table_obj.send(:prep_rows)
    end

    it 'calls puts' do
      expect(prime_table_obj).to receive(:puts).exactly(2*n).times
      prime_table_obj.send(:prep_rows)
    end
  end

  describe '#prep_row_str' do

    let(:n) { 10 }
    let(:prime_num_hash) {
      {
          1 => 2, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13, 7 => 17, 8 => 19, 9 => 23, 10 => 29
      }
    }
    let(:prime_table_obj) { subject.new(n, prime_num_hash) }
    let(:k) { 1 }
    let(:row_prime_num) { prime_num_hash[k] }
    let(:prime_str) {
      str_val = "\t"
      str_val + ' 2'.colorize(BOUND_COLOR)
    }
    let(:str) {
      str_val = prime_str
      str_val += "\t|\t".colorize(DASH_COLOR)
      str_val
    }

    it 'calls prep_prime_num_str' do
      expect(prime_table_obj).to receive(:prep_prime_num_str).exactly(1).times.with(row_prime_num).and_return prime_str
      prime_table_obj.send(:prep_row_str, k)
    end

    it 'calls prep_prime_num_str' do
      expect(prime_table_obj).to receive(:prep_dash_str).exactly(1).times.with("\t|\t").and_return str
      prime_table_obj.send(:prep_row_str, k)
    end

    it 'calls prep_prime_num_str' do
      expect(prime_table_obj).to receive(:prep_row_str_support).exactly(1).times.with(str, row_prime_num)
      prime_table_obj.send(:prep_row_str, k)
    end
  end

  describe '#prep_row_str_support' do

    let(:n) { 10 }
    let(:prime_num_hash) {
      {
          1 => 2, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13, 7 => 17, 8 => 19, 9 => 23, 10 => 29
      }
    }
    let(:prime_table_obj) { subject.new(n, prime_num_hash) }
    let(:str) { '' }
    let(:row_prime_num) { 2 }
    let(:output_str) {
      str_val = '  4'.colorize(ODD_COLOR) + "\t" + '  6'.colorize(EVEN_COLOR) + "\t"
      str_val += ' 10'.colorize(ODD_COLOR) + "\t" + ' 14'.colorize(EVEN_COLOR) + "\t" + ' 22'.colorize(ODD_COLOR)
      str_val += "\t" + ' 26'.colorize(EVEN_COLOR) + "\t" + ' 34'.colorize(ODD_COLOR) + "\t"
      str_val += ' 38'.colorize(EVEN_COLOR) + "\t" + ' 46'.colorize(ODD_COLOR) + "\t" + ' 58'.colorize(EVEN_COLOR)
      str_val + "\t"
    }

    it 'calls prep_color' do
      expect(prime_table_obj).to receive(:prep_color).exactly(n).times
      prime_table_obj.send(:prep_row_str_support, str, row_prime_num)
    end

    it 'calls prep_product_num_str' do
      expect(prime_table_obj).to receive(:prep_product_num_str).exactly(n).times.and_return str
      prime_table_obj.send(:prep_row_str_support, str, row_prime_num)
    end

    it 'returns string' do
      resp = prime_table_obj.send(:prep_row_str_support, str, row_prime_num)
      expect(resp).to be_kind_of(String)
      expect(resp).to eq(output_str)
    end
  end

  describe '#prep_headers_tab_count' do

    let(:n) { 10 }
    let(:prime_num_hash) {
      {
          1 => 2, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13, 7 => 17, 8 => 19, 9 => 23, 10 => 29
      }
    }
    let(:prime_table_obj) { subject.new(n, prime_num_hash) }
    let(:colored_dash) { '|'.colorize(DASH_COLOR) }
    let(:tab_count) { 2 }
    let(:str) {
      str_val = "\n\n\t\t"
      str_val + colored_dash
    }
    let(:str_tab_count_arr) {
      prime_table_obj.send(:prep_headers_tab_count_support, str, tab_count)
    }
    let(:tab_count_output) { 12 }

    it 'calls prep_dash_str' do
      expect(prime_table_obj).to receive(:prep_dash_str).exactly(1).times.with('|').and_return colored_dash
      prime_table_obj.send(:prep_headers_tab_count)
    end

    it 'calls prep_headers_tab_count_support' do
      expect(prime_table_obj).to receive(:prep_headers_tab_count_support).exactly(1)
                                     .times.with(str, tab_count).and_return str_tab_count_arr
      prime_table_obj.send(:prep_headers_tab_count)
    end

    it 'calls puts' do
      expect(prime_table_obj).to receive(:puts).exactly(1).times.with(str_tab_count_arr[0])
      prime_table_obj.send(:prep_headers_tab_count)
    end

    it 'returns tab count' do
      resp = prime_table_obj.send(:prep_headers_tab_count)
      expect(resp).to eq(tab_count_output)
    end

  end

  describe '#prep_headers_tab_count_support' do

    let(:n) { 10 }
    let(:prime_num_hash) {
      {
          1 => 2, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13, 7 => 17, 8 => 19, 9 => 23, 10 => 29
      }
    }
    let(:prime_table_obj) { subject.new(n, prime_num_hash) }
    let(:str) {
      str_val = "\n\n\t\t"
      str_val += prime_table_obj.send(:prep_dash_str, '|')
      str_val
    }
    let(:tab_count) { 2 }
    let(:output_str) {
      str_val = str + "\t" + '  2'.colorize(BOUND_COLOR) + "\t" + '  3'.colorize(BOUND_COLOR) + "\t"
      str_val += '  5'.colorize(BOUND_COLOR) + "\t" + '  7'.colorize(BOUND_COLOR) + "\t" + ' 11'.colorize(BOUND_COLOR)
      str_val += "\t" + ' 13'.colorize(BOUND_COLOR) + "\t" + ' 17'.colorize(BOUND_COLOR) + "\t"
      str_val += ' 19'.colorize(BOUND_COLOR) + "\t" + ' 23'.colorize(BOUND_COLOR) + "\t" + ' 29'.colorize(BOUND_COLOR)
      str_val
    }
    let(:expected_output) {
      [
          output_str,
          12
      ]
    }

    it 'returns an array' do
      resp = prime_table_obj.send(:prep_headers_tab_count_support, str, tab_count)
      expect(resp).to eq(expected_output)
    end
  end

  describe '#prep_dash_str' do

    let(:n) { 10 }
    let(:prime_num_hash) {
      {
          1 => 2, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13, 7 => 17, 8 => 19, 9 => 23, 10 => 29
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
          1 => 2, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13, 7 => 17, 8 => 19, 9 => 23, 10 => 29
      }
    }
    let(:prime_table_obj) { subject.new(n, prime_num_hash) }
    let(:prime_num) { prime_num_hash[prime_num_hash.keys.length] }
    let(:color_hash) { BOUND_COLOR }
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
          1 => 2, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13, 7 => 17, 8 => 19, 9 => 23, 10 => 29
      }
    }
    let(:prime_table_obj) { subject.new(n, prime_num_hash) }
    let(:product) { prime_num_hash[prime_num_hash.keys.length] * prime_num_hash[prime_num_hash.keys.length] }
    let(:color_hash) { BOUND_COLOR }
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
          1 => 2, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13, 7 => 17, 8 => 19, 9 => 23, 10 => 29
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
          1 => 2, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13, 7 => 17, 8 => 19, 9 => 23, 10 => 29
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
          1 => 2, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13, 7 => 17, 8 => 19, 9 => 23, 10 => 29
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
          1 => 2, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13, 7=> 17, 8 => 19, 9 => 23, 10 => 29
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
          1 => 2, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13, 7=> 17, 8 => 19, 9 => 23, 10 => 29
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
            1 => 2, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13, 7=> 17
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
            1 => 2, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13
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
            1 => 2, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13, 7=> 17
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
            1 => 2, 2 => 3, 3 => 5, 4 => 7, 5 => 11, 6 => 13
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