# frozen_string_literal: true
module Year2024
  class Day14 < Solution

    def parse_data
      data.map{_1.scan(/-?\d+/).map(&:to_i)}
    end

    def update(c, r, vc, vr)
      [(c+vc) % $limit_c, (r+vr) % $limit_r, vc, vr]
    end

    def debug(robots)
      pos_counter = Hash.new(0)
      robots.each{pos_counter[[_1[1],_1[0]]] += 1}
      for r in 0...$limit_r
        line = ''
        for c in 0...$limit_c
          line += pos_counter.has_key?([r, c]) ? pos_counter[[r, c]].to_s : '.'
        end
        p line
      end
    end

    def calc_split_quadrant(robots)
      mid_r, mid_c = $limit_r/2, $limit_c/2
      res = Array.new(4, 0)
      robots.each{_1 => [c, r, _, _]
        if    r < mid_r and c < mid_c then res[0] += 1
        elsif r < mid_r and c > mid_c then res[1] += 1
        elsif r > mid_r and c < mid_c then res[2] += 1
        elsif r > mid_r and c > mid_c then res[3] += 1
        end
      }
      res.inject(:*)
    end

    def part_1
      ENV['RB_ENV'] ? ($limit_r, $limit_c = 7, 11) : ($limit_r, $limit_c = 103, 101)
      robots = parse_data
      (0...100).each{robots.map!{update(*_1)}}
      calc_split_quadrant robots
    end

    def is_connected_beyond_threshold(robots)
      pos = Set[*robots.map{[_2, _1]}]

      max_connected = 0
      res = []
      for r in 0...$limit_r
        latest = -1

        for c in pos.filter_map{_1 if _2 == r}.sort
          if latest + 1 == c
            max_connected += 1
          else
            res << max_connected
            max_connected = 0
          end
          latest = c
        end
      end
      res.max > $limit_c/5 # magic number
    end

    def part_2
      $limit_r, $limit_c = 103, 101
      robots = parse_data

      res = 0
      while res < $limit_r * $limit_c
        robots.map!{update(*_1)}
        res += 1
        break if is_connected_beyond_threshold robots
      end
      # debug robots
      res
    end
  end
end
