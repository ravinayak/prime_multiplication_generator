# Used for namespacing
#
module PrimeMultiplicationGenerator
  # Class used for generating primes
  #
  class PrimeMultiplicationTable

    attr_accessor :num_of_primes, :prime_num_hash, :max_prime_digit, :max_product_digit, :no_of_chars,
                  :prime_num_range

    def initialize(num_of_primes, prime_num_hash)
      @num_of_primes = num_of_primes
      @prime_num_hash = prime_num_hash
      @max_prime_digit = prep_max_prime_digit
      @max_product_digit = prep_max_product_digit
      @prime_num_range = (1..num_of_primes)
    end

    # Public Interface to draw the multiplication table of primes
    #
    def display_table
      tab_count = prep_headers_tab_count
      prep_header_border(tab_count)
      prep_rows
    end

    private

    # Draws rows for each prime number hash
    # @return [NIL]
    #
    def prep_rows
      self.prime_num_range.each do |k|
        puts prep_row_str(k)
      end
    end

    # Prepares str for each row
    # @param k [Integer]
    # @return [String]
    #
    def prep_row_str(k)
      row_prime_num = self.prime_num_hash[k]
      str = "\t"
      str += display_prime_num(row_prime_num)
      str += "\t|\t"
      self.prime_num_range.each do |i|
        str += display_product_num(row_prime_num * self.prime_num_hash[i])
        str += "\t"
      end
      str
    end

    # Draws the table based on input
    # @return [NIL]
    #
    def prep_headers_tab_count
      str, tab_count = "\t\t", 2
      str += '|'
      self.prime_num_range.each do |num|
        str += "\t"
        tab_count += 1
        str += display_product_num(self.prime_num_hash[num])
      end
      puts str
      tab_count
    end

    # Prepares Border
    # @param tab_count [Integer]
    # @return [NIL]
    #
    def prep_header_border(tab_count)
      str = ''
      self.no_of_chars = (tab_count + 1 ) * 8
      (1..self.no_of_chars).each { str += '-' }
      puts "#{str}"
    end

    # Generates the maximum prime digit
    #
    def prep_max_prime_digit
      self.max_prime_digit = self.prime_num_hash[self.num_of_primes]
      Math.log10(self.max_prime_digit).to_i + 1
    end

    # Generates the maximum product digit
    #
    def prep_max_product_digit
      self.max_product_digit = self.prime_num_hash[self.num_of_primes] * self.prime_num_hash[self.num_of_primes]
      Math.log10(self.max_product_digit).to_i + 1
    end

    # Displays prime number right justified to the max prime digit available
    # @param prime_num [Integer]
    # @return [String]
    #
    def display_prime_num(prime_num)
      "#{prime_num.to_s.rjust(self.max_prime_digit)}"
    end

    # Displays product right justified to the max prime digit available
    # @param product [Integer]
    # @return [String]
    #
    def display_product_num(product)
      "#{product.to_s.rjust(self.max_product_digit)}"
    end
  end
end
