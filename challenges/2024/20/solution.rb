# frozen_string_literal: true
module Year2024
  class Day20 < Solution

    require 'parallel'
    require 'matrix'
    require 'algorithms'
    include Containers

    def parse_data
      map = Matrix[*data.map(&:chars)]
      $limit_r, $limit_c = map.row_count, map.column_count
      [map, map.index(?S), map.index(?E)]
    end

    def in_map?(r, c)
      (0..$limit_r).include?(r) and (0..$limit_c).include?(c)
    end

    def get_adjacents(r, c)
      [[r + 1, c], [r - 1, c], [r, c + 1], [r, c - 1]]
        .filter{in_map?(*_1)}
    end

    def traverse(r,c, path, goal, map)
      queue = Queue.new([[r,c,path]])
      visited = Set.new([[r,c]])
      until queue.empty?
        r, c, path = queue.pop
        return path + [[r, c]] if [r, c] == goal
        get_adjacents(r,c)
          .filter{|nr,nc| map[nr, nc] != '#' and !visited.include?([nr,nc])}
          .each {|neighbor|
            visited.add(neighbor)
            queue.push([*neighbor, path + [[r, c]]])
          }
      end
    end

    def find_shortcut(path, map, span)
      lookup = Hash.new(-Float::INFINITY).merge(path.each_with_index.to_h)
      Parallel.flat_map(path.each_with_index) {|(r, c), i|
        (-span..span).to_a.product((-span..span).to_a).filter_map{|dr, dc|
          cheat_path = dr.abs + dc.abs
          nr, nc = r + dr, c + dc
          if cheat_path <= span and in_map?(nr,nc) and lookup[[nr,nc]] > i
            diff = lookup[[nr,nc]] - i - cheat_path
            diff if diff > 0
          end
        }
      }.tally
    end

    def solve(limit, span)
      map, start, goal = parse_data
      path = traverse(*start, [], goal, map)
      find_shortcut(path, map, span).to_a
        .filter_map{|cheat_amnt, count| count if cheat_amnt >= limit}.sum
    end

    def part_1
      ENV['RB_ENV'] == 'test' ? (least = 2) : (least = 100)
      solve(least, 2)
    end

    def part_2
      ENV['RB_ENV'] == 'test' ? (least = 50) : (least = 100)
      solve(least, 20)
    end

  end
end

# def get_diff
#   [[1, 0], [-1, 0], [0, 1], [0, -1]]
# end

# def get_skipable(r,c,map)
#   get_diff.map {|dr, dc| [r + dr, c + dc, r + dr + dr, c + dc + dc]}
#     .filter{
#       (0..$limit_r).include?(_3) and (0..$limit_c).include?(_4) and
#       map[_1, _2] == '#' and map[_3, _4] != '#'
#     }
#     .map{|nr, nc, nnr, nnc| [nnr, nnc]}
# end

# def find_shortcut(path, map)
#   lookup_path_idx = path.each_with_index.to_h
#   Parallel.flat_map(path.each_with_index) {|(r, c), i|
#     get_skipable(r,c,map).filter_map{|nr,nc|
#       # diff - walk amount
#       (lookup_path_idx[[nr, nc]] - i - 2) if lookup_path_idx.has_key?([nr,nc])
#     }.flatten
#   }.reduce(Hash.new(0)) { |h, e| h[e] += 1 ; h }
# end
