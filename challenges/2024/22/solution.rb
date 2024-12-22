# frozen_string_literal: true
module Year2024
  class Day22 < Solution

    require 'parallel'

    $mix = -> val, secret { val ^ secret }
    $prune = -> val { val % 16777216 }
    $proc1 = -> x { $prune[$mix[x, x * 64]] }
    $proc2 = -> x { $prune[$mix[x, x / 32]] }
    $proc3 = -> x { $prune[$mix[x, x * 2048]] }
    $proc  = -> x { [$proc1, $proc2, $proc3].reduce(x){|acc, proc| proc[acc]} }

    def part_1
      nums = data.map(&:to_i)
      procs = [$proc].cycle(2000)

      Parallel.map(nums) {|num| procs.reduce(num){|acc,proc| proc[acc]} }.sum
    end

    def part_2
      nums = data.map(&:to_i)
      procs = [$proc].cycle(2000)

      buyer_patterns = Parallel.map(nums) {|num|
        Hash.new(0).merge(
          procs.reduce([num, [], []]){|(last, changes, pattern), proc|
            price = proc[last]
            digit = price.digits[0]
            new_changes = changes + [digit - last.digits[0]]
            [price, new_changes, pattern + [[new_changes[-4..-1], digit]]]
          }[2]
            .reject{|pattern, _val| pattern.nil?}
            .reverse.to_h # get pattern from first occurrence
        )
      }

      all_possible_patterns = Set[*buyer_patterns.flat_map{_1.keys}]
      Parallel.map(all_possible_patterns){|pattern|
        buyer_patterns.sum{|buyer_pattern| buyer_pattern[pattern]}
      }.max
    end

  end
end
