# frozen_string_literal: true
module Year2024
  class Day03 < Solution
    $mul_regex = /mul\(\d+,\d+\)/
    def mul_text_to_i(str)
      str.scan(/\d+/).map(&:to_i).inject(:*)
    end

    def part_1
      data.join('').scan($mul_regex).sum{mul_text_to_i _1}
    end

    def part_2
      keyword_regex = Regexp.union(/don't\(\)|do\(\)/, $mul_regex)
      data.join('').scan(keyword_regex).reduce([0, :do]) {|acc, capture|
        acc => [sum, state]
        case [state, capture]
        in [*, "don't()"] then [sum, :dont]
        in [*, "do()"] then [sum, :do]
        in [:dont, String] then [sum, :dont]
        in [:do, String] then [sum + mul_text_to_i(capture), :do]
        end
      }[0]
    end
  end
end
