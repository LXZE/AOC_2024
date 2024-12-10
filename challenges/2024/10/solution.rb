# frozen_string_literal: true
module Year2024
  class Day10 < Solution

    def get_adjacents(r, c)
      [
        [r-1, c], # ^
        [r, c+1], # >
        [r+1, c], # v
        [r, c-1], # <
      ].filter{
        (0...$limit_row).include?(_1) and (0...$limit_col).include?(_2)
      }
    end

    def get_score(pos, current, map)
      return pos if current == 9
      get_score(
        pos.flat_map{get_adjacents(_1, _2)}.uniq.filter{map[_1][_2] == current + 1},
        current + 1, map
      )
    end

    def get_data
      map = data.map{_1.chars.map(&:to_i)}
      $limit_row, $limit_col = map.size, map[0].size
      start_pos = []
      map.each_with_index{|row, row_idx|
        row.each_with_index{|char, col_idx|
          start_pos.push([row_idx, col_idx]) if char == 0
        }
      }
      [map, start_pos]
    end

    def part_1
      map, start_pos = get_data
      start_pos.sum{get_score([[_1, _2]], 0, map).size}
    end

    def get_rating(pos, current, map)
      return 1 if current == 9
      get_adjacents(*pos).filter{map[_1][_2] == current + 1}
        .sum{get_rating(_1, current+1, map)}
    end

    def part_2
      map, start_pos = get_data
      start_pos.sum{get_rating([_1, _2], 0, map)}
    end

  end
end
