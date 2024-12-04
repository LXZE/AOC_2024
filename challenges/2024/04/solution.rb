# frozen_string_literal: true
module Year2024
  class Day04 < Solution

    def part_1
      matrix = data.map(&:chars)
      sum = 0
      for row_idx in 0...matrix.size
        for col_idx in 0...matrix[0].size
          sum += [
            [[0, 0], [0, 1], [0, 2], [0, 3]], # >
            [[0, 0], [1, 1], [2, 2], [3, 3]], # \
            [[0, 0], [1, 0], [2, 0], [3, 0]], # v
            [[0, 0], [1, -1], [2, -2], [3, -3]], # /
            [[0, 0], [0, -1], [0, -2], [0, -3]], # <
            [[0, 0], [-1, -1], [-2, -2], [-3, -3]], # \
            [[0, 0], [-1, 0], [-2, 0], [-3, 0]], # ^
            [[0, 0], [-1, 1], [-2, 2], [-3, 3]], # /
          ]
            .map{_1.map{|dr,dc| [row_idx+dr, col_idx+dc]}}
            .map{_1.map{|r, c| if r >= 0 and c >= 0 then matrix.dig(r, c) end}}
            .filter{_1.all?}
            .map{_1.join('')}
            .count("XMAS")
        end
      end
      sum
    end

    def part_2
      matrix = data.map(&:chars)
      sum = 0
      for row_idx in 0...matrix.size
        for col_idx in 0...matrix[0].size
          target = [[0, 0], [1, 1], [2, 2], [0, 2], [1, 1], [2, 0]]
            .map{|dr,dc| [row_idx+dr, col_idx+dc]}
            .map{|r, c| matrix.dig(r, c)}
            .reject(&:nil?)
            .join('')
          if /MASMAS|MASSAM|SAMMAS|SAMSAM/.match?(target)
            sum += 1
          end
        end
      end
      sum
    end

  end
end
