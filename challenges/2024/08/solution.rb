# frozen_string_literal: true
module Year2024
  class Day08 < Solution

    def get_antennas
      antennas = Hash.new {|hash, key| hash[key] = Set.new}
      map = data.map(&:chars)
      $limit_r, $limit_c = map.size, map[0].size

      map.each_with_index.map{|row, r|
        row.each_with_index {|char, c|
          antennas[char] << [r, c] unless char == '.'
        }
      }
      antennas
    end

    def get_2_antinodes(pos_a, pos_b)
      pos_a => {r: ar, c: ac}
      pos_b => {r: br, c: bc}
      dr, dc = (ar-br).abs, (ac-bc).abs
      # [ar, br] always in order as we create from r <- 0...$limit
      [
        {r: ar-dr, c: ac<bc ? ac-dc : ac+dc},
        {r: br+dr, c: ac<bc ? bc+dc : bc-dc},
      ]
    end

    def in_map(pos)
      pos => {r:, c:}
      (0...$limit_r).include?(r) and (0...$limit_c).include?(c)
    end

    $to_struct = -> r, c { {r:, c:} }

    def part_1
      Set[*get_antennas.flat_map {|antenna, positions|
        positions.to_a.combination(2).flat_map{
          get_2_antinodes($to_struct[*_1], $to_struct[*_2])
        }.filter{in_map _1}
      }].size
    end

    def get_all_antinodes(pos_a, pos_b)
      pos_a => {r: ar, c: ac}
      pos_b => {r: br, c: bc}
      dr, dc = (ar-br).abs, (ac-bc).abs

      get_lower_candidate = -> { {r: ar-dr, c: ac<bc ? ac-dc : ac+dc} }
      get_upper_candidate = -> { {r: br+dr, c: ac<bc ? bc+dc : bc-dc} }

      ga = Enumerator.new {|g|
        candidate = get_lower_candidate[]
        while in_map(candidate)
          g << candidate
          candidate => {r: ar, c: ac}
          candidate = get_lower_candidate[]
        end
      }

      gb = Enumerator.new {|g|
        candidate = get_upper_candidate[]
        while in_map(candidate)
          g << candidate
          candidate => {r: br, c: bc}
          candidate = get_upper_candidate[]
        end
      }
      [pos_a, pos_b, *ga.to_a, *gb.to_a] # self is also antinode
    end

    def part_2
      Set[*get_antennas.flat_map {|antenna, positions|
        positions.to_a.combination(2).flat_map{
          get_all_antinodes($to_struct[*_1], $to_struct[*_2])
        }
      }].size
    end
  end
end
