# frozen_string_literal: true
module Year2024
  class Day01 < Solution

    def part_1
      data.map{_1.split('   ').map(&:to_i)}.transpose \
        .map(&:sort).transpose \
        .map{|a,b| (a-b).abs}.sum
    end

    def part_2
      l, r = data.map{_1.split('   ').map(&:to_i)}.transpose
      l.map{_1 * r.count(_1)}.sum
    end

  end
end
