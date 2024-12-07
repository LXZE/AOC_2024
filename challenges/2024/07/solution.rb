# frozen_string_literal: true
module Year2024
  class Day07 < Solution
    require 'parallel'

    def is_equal?(current, nums, target)
      return current == target if nums.empty?
      return false if current > target
      next_num, *new_nums = nums
      [current+next_num, current*next_num]
        .any?{is_equal? _1, new_nums, target}
    end

    def part_1
      data.map{l, r = _1.split(': '); [l, *r.split].map(&:to_i)}
        .filter{|l, r, *rs| is_equal? r, rs, l }
        .sum{_1[0]}
    end

    $concat = -> a, b { (a.to_s + b.to_s).to_i }

    def is_equal_with_concat?(current, nums, target)
      return current == target if nums.empty?
      return false if current > target
      next_num, *new_nums = nums
      [current+next_num, current*next_num, $concat[current, next_num]]
        .any?{is_equal_with_concat? _1, new_nums, target}
    end

    def part_2
      eqs = data.map{l, r = _1.split(': '); [l, *r.split].map(&:to_i)}
      Parallel.map(eqs) {|l, r, *rs| [l, is_equal_with_concat?(r, rs, l)] }
        .filter{_2}
        .sum{_1[0]}
    end

  end
end
