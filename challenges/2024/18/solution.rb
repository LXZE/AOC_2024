# frozen_string_literal: true
module Year2024
  class Day18 < Solution

    require 'algorithms'
    include Containers
    require 'parallel'

    def parse_data # x,y -> r,c
      data.map{_1.split(',').map(&:to_i).reverse}
    end

    def get_adjacents(r, c)
      [[r + 1, c], [r - 1, c], [r, c + 1], [r, c - 1]].filter{
        (0..$limit_r).include?(_1[0]) && (0..$limit_c).include?(_1[1])
      }
    end

    def bfs(start, goal, obstacles)
      queue = Queue.new([[start]])
      visited = Set.new([[start]])

      until queue.empty?
        path = queue.pop
        node = path.last
        return path if node == goal
        neighbors = get_adjacents(*node).filter{
          !visited.include?(_1) and !obstacles.include?(_1)
        }
        neighbors.each {|neighbor|
          visited.add(neighbor)
          queue.push(path + [neighbor])
        }
      end
      nil
    end

    def part_1
      # limit = size - 1 for this one
      ENV['RB_ENV'] \
        ? ($limit_r, $limit_c = 6,6;    $limit_bytes = 12) \
        : ($limit_r, $limit_c = 70,70;  $limit_bytes = 1024)

      obstacles = Set[*parse_data[0...$limit_bytes]]
      bfs([0,0], [$limit_r, $limit_c], obstacles).size - 1
    end

    def part_2
      bytes = parse_data
      obstacles = Set[*bytes[0...$limit_bytes]]

      # could do binary search but too lazy for now, brute force goes brrrrr
      Parallel.map(0...(bytes.size - $limit_bytes)) { |offset|
        new_bytes = bytes[$limit_bytes..($limit_bytes+offset)]
        bytes[$limit_bytes+offset].reverse.join(',') \
          if bfs([0,0], [$limit_r, $limit_c], obstacles | new_bytes).nil?
      }.compact.first
    end
  end
end
