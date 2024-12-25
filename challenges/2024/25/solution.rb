# frozen_string_literal: true
module Year2024
  class Day25 < Solution

    def parse_data
      grouped = @input.split(/\n\n/).map{_1.split(/\n/)}.group_by{_1[0].chars.all? '#'}
      [grouped[true], grouped[false]]
    end

    def part_1
      locks, keys = parse_data
      locks.map!{|lock| lock.map(&:chars).transpose.map{_1.count('#') - 1}}
      keys.map!{|key| key.map(&:chars).transpose.map{_1.count('#') - 1}}

      locks.product(keys).count{|lock,key| lock.zip(key).all?{ (_1+_2) < 6 } }
    end

    def part_2
      'Merry X\'mas'
    end

  end
end
