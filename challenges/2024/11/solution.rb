# frozen_string_literal: true
module Year2024
  class Day11 < Solution

    $cache = {}
    def apply_rule(number, current, target)
      return 1 if current == target
      return $cache[[number, current]] if $cache.has_key? [number, current]

      if number == 0
        candidate = [1]
      elsif number.digits.size % 2 == 0
        s_number = number.to_s
        mid = number.digits.size / 2
        candidate = [s_number[...mid], s_number[mid..]].map(&:to_i)
      else
        candidate = [number*2024]
      end

      $cache[[number, current]] = candidate.sum{apply_rule(_1, current+1, target)}
    end

    def solve(target)
      $cache = {}
      data.split.map(&:to_i).sum{apply_rule(_1, 0, target)}
    end

    def part_1
      solve(25)
    end

    def part_2
      solve(75)
    end

  end
end
