# frozen_string_literal: true
module Year2024
  class Day12 < Solution

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

    def group_char(given_char, map)
      possible_pos = Set[]
      map.each_with_index { |row, row_idx|
        row.each_with_index { |char, col_idx|
          possible_pos.add([row_idx, col_idx]) if given_char == char
        }
      }

      res = []
      while possible_pos.size > 0
        group = []
        connections = 0

        # get one position to start
        possible_pos = possible_pos.to_a
        cdd = [possible_pos.shift]
        possible_pos = Set[*possible_pos]

        # keep expand and grouping & counting connection
        while cdd.size > 0
          group.push(*cdd)
          cdd = cdd.flat_map{get_adjacents(*_1)}.filter{possible_pos.include? _1}
          connections += cdd.size
          cdd = cdd.uniq
          possible_pos -= cdd
        end
        res << {group:, char: given_char, perim: ((group.size * 2) - connections)*2}
      end
      res
    end

    def part_1
      map = data.map(&:chars)
      $limit_row, $limit_col = map.size, map[0].size

      map.flatten.uniq.sum{|char|
        group_char(char, map).sum{_1 => {group: ,perim: }; group.size*perim}
      }
    end

    def get_face(map)
      boarder = ['.']*$limit_col
      lookup = Hash.new(0)

      # scan 2 rows with 2 cols
      [boarder, *map].each_cons(2).with_index {|rs, row_idx|
        rs => [r1, r2]
        prev = []
        r1.zip(r2).each_with_index{|ps, col_idx|
          ps => [p1, p2]
          if (p1 != p2) and (prev[1] != p2 or (prev[0] == prev[1] and prev[1] == p2))
            lookup[p2] += 1
          end
          prev = [p1, p2]
        }
      }
      lookup
    end

    def part_2
      map = data.map(&:chars)
      $limit_row, $limit_col = map.size, map[0].size

      current = 0
      regions_size = map.flatten.uniq.flat_map{group_char(_1, map)}
        .reduce({}){|acc, entry|
          entry => {char: ,group:}
          if acc.has_key?(char)
            acc[current] = group.size
            # prevent duplicate char in map by replacing with number
            group.each{|r,c| map[r][c] = current}
            current += 1
          else
            acc[char] = group.size
          end
          acc
        }

      [
        get_face(map),
        get_face(map.transpose),
        get_face(map.reverse),
        get_face(map.transpose.reverse),
      ].reduce({}){|acc, res_map|
        acc.merge(res_map){|key, acc, new_size| acc + new_size}
      }.merge(regions_size){_2*_3}.values.sum
    end

  end
end
