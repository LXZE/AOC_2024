# frozen_string_literal: true
module Year2024
  class Day05 < Solution

    def parse_data
      splitter = data.index('')
      [
        Set[*data[...splitter].map{_1.split("|").map(&:to_i)}],
        data[(splitter+1)..].map{_1.split(",").map(&:to_i)}
      ]
    end

    def is_valid?(rules, order)
      last = order.size - 1
      order.each_with_index.all? {|number, i|
        order[i+1..last].all?{!rules.include?([_1, number])}
      }
    end

    def part_1
      rules, orders = parse_data
      orders.filter{is_valid? rules, _1}
        .sum{_1[_1.size/2]}
    end

    def fix(rules, order)
      dones = Array.new(order.size, false)
      while not dones.all?
        for number, i in order.each_with_index
          next if dones[i]

          error_idx = order[i+1...].find_index{rules.include?([_1, number])}
          if not error_idx.nil?
            error_idx += i+1
            order[error_idx], order[i] = order[i], order[error_idx]
            break
          end

          dones[i] = true
        end
      end
      order
    end

    def part_2
      rules, orders = parse_data
      orders.reject{is_valid? rules, _1}
        .map{fix rules, _1}
        .sum{_1[_1.size/2]}
    end

  end
end
