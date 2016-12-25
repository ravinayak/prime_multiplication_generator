require 'prime_multiplication_generator/color_selections'
# Used for namespacing
#
module PrimeMultiplicationGenerator
  # Class used for generating primes
  #
  class PrimeMultiplicationTable
    # Includes a module for color selections
    #
    include ColorSelections

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
        puts
      end
    end

    # Prepares str for each row
    # @param k [Integer]
    # @return [String]
    #
    def prep_row_str(k)
      row_prime_num = self.prime_num_hash[k]
      str = "\t"
      str += prep_prime_num_str(row_prime_num)
      str += prep_dash_str("\t|\t")
      prep_row_str_support(str, row_prime_num)
    end

    # Prepares string for each row of product
    # @param str [String]
    # @param row_prime_num [Integer]
    # @return [String]
    #
    def prep_row_str_support(str, row_prime_num)
      self.prime_num_range.each do |i|
        color_hash = prep_color(i)
        str += prep_product_num_str(row_prime_num * self.prime_num_hash[i], color_hash)
        str += "\t"
      end
      str
    end

    # Draws the table based on input
    # @return [NIL]
    #
    def prep_headers_tab_count
      str, tab_count = "\n\n\t\t", 2
      str += prep_dash_str('|')
      str, tab_count = prep_headers_tab_count_support(str, tab_count)
      puts str
      tab_count
    end

    # Prepares string for headers and tab count
    # @param str [String]
    # @param tab_count [Integer]
    # @return [Array]
    #
    def prep_headers_tab_count_support(str, tab_count)
      self.prime_num_range.each do |num|
        str += "\t"
        tab_count += 1
        str += prep_product_num_str(self.prime_num_hash[num], BOUNDARY_PRIME_COLOR)
      end
      [
          str,
          tab_count
      ]
    end
    # Displays dash string
    # @param input_str [String]
    # @return [String]
    #
    def prep_dash_str(input_str)
      input_str.colorize(DASH_COLOR)
    end

    # Returns string for prime number display
    # @param row_prime_num [Integer]
    # @return [String]
    #
    def prep_prime_num_str(row_prime_num)
      display_prime_num(row_prime_num).colorize(BOUNDARY_PRIME_COLOR)
    end

    # Returns string for product number display
    # @param product_num [Integer]
    # @param color_hash [Hash]
    # @return [String]
    #
    def prep_product_num_str(product_num, color_hash)
      display_product_num(product_num).colorize(color_hash)
    end

    # Prepares Border
    # @param tab_count [Integer]
    # @return [NIL]
    #
    def prep_header_border(tab_count)
      str = ''
      self.no_of_chars = (tab_count + 1 ) * 8
      (1..self.no_of_chars).each { str += '-' }
      puts "#{prep_dash_str(str)}"
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

    # Determines color based on input
    # @param n [Integer]
    # @return [Hash]
    #
    def prep_color(n)
      return EVEN_COLOR if is_even?(n)
      ODD_COLOR
    end

    # Determines if input is even or odd
    # @param n [Integer]
    # @return [TrueClass/FalseClass]
    #
    def is_even?(n)
      return true if n % 2 == 0
      false
    end
  end
end
