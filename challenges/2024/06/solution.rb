# frozen_string_literal: true
module Year2024
  class Day06 < Solution
    require 'matrix'
    require 'parallel'

    def in_map?(limit_r, limit_c, current_r, current_c)
      (0...limit_r).include?(current_r) and (0...limit_c).include?(current_c)
    end

    def get_next_pos(guard, pos_r, pos_c)
      case guard
      in :^ then [pos_r-1, pos_c]
      in :> then [pos_r, pos_c+1]
      in :v then [pos_r+1, pos_c]
      in :< then [pos_r, pos_c-1]
      end
    end

    def get_next_guard(guard)
      case guard
      in :^ then :>
      in :> then :v
      in :v then :<
      in :< then :^
      end
    end

    def gen_traversed_route(map, pos_r, pos_c, guard)
      row_size, col_size = map.row_size(), map.column(0).size
      traversed = [[pos_r, pos_c]]

      while in_map?(row_size, col_size, pos_r, pos_c)
        next_r, next_c = get_next_pos(guard, pos_r, pos_c)
        if in_map?(row_size, col_size, next_r, next_c) and map[next_r, next_c] == '#'
          guard = get_next_guard guard
        else
          pos_r, pos_c = next_r, next_c
          if in_map?(row_size, col_size, pos_r, pos_c)
            traversed.push([pos_r, pos_c])
          end
        end
      end
      traversed
    end

    def part_1
      map = Matrix[*data.map(&:chars)]
      pos_r, pos_c = map.find_index '^'
      guard = '^'.to_sym
      map[pos_r, pos_c] = "."
      Set[*gen_traversed_route(map, pos_r, pos_c, guard)].size
    end


    def is_loop?(map, pos_r, pos_c, guard)
      row_size, col_size = map.row_size(), map.column(0).size
      found_obstacles = Set[]

      while in_map?(row_size, col_size, pos_r, pos_c)
        next_r, next_c = get_next_pos(guard, pos_r, pos_c)
        if in_map?(row_size, col_size, next_r, next_c) and map[next_r, next_c] == '#'
          return true if found_obstacles.include?([next_r, next_c, guard])
          found_obstacles.add([next_r, next_c, guard])
          guard = get_next_guard guard
        else
          pos_r, pos_c = next_r, next_c
          return false unless in_map?(row_size, col_size, pos_r, pos_c)
        end
      end
    end

    def part_2
      map = Matrix[*data.map(&:chars)]
      pos_r, pos_c = map.find_index '^'
      guard = '^'.to_sym
      map[pos_r, pos_c] = "."
      traversed_path = Set[*gen_traversed_route(map, pos_r, pos_c, guard)]
        .delete([pos_r, pos_c])

      Parallel.map(traversed_path) {|candidate_r, candidate_c|
        blocked_map = map.clone()
        blocked_map[candidate_r, candidate_c] = '#'
        is_loop?(blocked_map, pos_r, pos_c, guard)
      }.count(true)
    end

  end
end
