# frozen_string_literal: true
module Year2024
  class Day16 < Solution

    require 'matrix'
    require 'algorithms'
    include Containers

    def parse_data
      map = Matrix[*data.map(&:chars)]
      $limit_r, $limit_c = map.row_count, map.column_count
      [map, map.index(?S), map.index(?E)]
    end

    def scan_map(map, symbol) # scan by row
      res = Hash.new{|h,k| h[k] = Set[]}
      for r in 1...($limit_r-1)
        latest = nil
        for c in 1...($limit_c-1)
          next if map[r,c] == '#'
          if latest.nil?
            latest = [r,c]
            next
          end
          if (map[r-1,c] == '.' or map[r+1,c] == '.' or map[r,c] == ?S or map[r,c] == ?E) # if have separate path
            if map[r, (latest[1]..c)].all?{_1 != '#'} # check if connected
              prev_r, prev_c = latest
              res[[prev_r, prev_c]] |= [[r,c, symbol]]
              res[[r,c]] |= [[prev_r, prev_c, symbol]]
            end
            latest = [r,c]
          end
        end
      end
      res
    end

    def diff(ar, ac, br, bc)
      (ar - br).abs + (ac - bc).abs
    end

    def get_traversed_positions(ar,ac,br,bc)
      if ar == br
        min_c, max_c = [ac,bc].sort
        (min_c..max_c).map{|c| [ar, c]}
      elsif ac == bc
        min_r, max_r = [ar,br].sort
        (min_r..max_r).map{|r| [r, ac]}
      else
        raise "Invalid positions"
      end
    end

    def traverse_dijkstra(start_r, start_c, start_dir, start_cost, target, graph, part2 = false)
      pq = Containers::MinHeap.new
      pq.push([start_cost, start_r, start_c, start_dir, [[start_r, start_c]]])
      visited = Hash.new(Float::INFINITY)
      visited[[start_r, start_c, start_dir]] = start_cost

      traversed_paths = []
      min_answer = Float::INFINITY
      until pq.empty?
        cost, r, c, dir, paths = pq.pop
        return [cost] if not part2 and [r, c] == target
        if [r, c] == target
          # p [cost, r, c, dir]
          if min_answer == Float::INFINITY
            traversed_paths.push(paths)
            min_answer = cost
          elsif cost <= min_answer
            traversed_paths.push(paths)
          elsif cost > min_answer
            return [min_answer, traversed_paths]
          end
        end

        graph[[r, c]].each {|nr, nc, ndir|
          next_cost = cost + (ndir == dir ? 0 : 1000) + diff(r, c, nr, nc)
          # instead of <, use <= for traverse all paths with same cost in part 2
          if (part2 and next_cost <= visited[[nr, nc, ndir]]) \
            or next_cost < visited[[nr, nc, ndir]]
            visited[[nr, nc, ndir]] = next_cost
            pq.push([next_cost, nr, nc, ndir, paths + [[nr, nc]]])
          end
        }
      end
      [min_answer, traversed_paths]
    end

    def get_data
      map, start_pos, end_pos = parse_data
      graph = scan_map(map, :-)
        .merge(
          scan_map(map.t, :|)
            # reverse row & col as it transposed
            .map{|k,v| [k.reverse, Set[*v.map{[_2, _1, _3]}]]}.to_h
        ) {|k, v1, v2| v1 | v2}
      [graph, start_pos, end_pos]
    end

    def part_1
      graph, start_pos, end_pos = get_data
      traverse_dijkstra(*start_pos, :-, 0, end_pos, graph)[0]
    end

    def part_2
      graph, start_pos, end_pos = get_data
      traverse_dijkstra(*start_pos, :-, 0, end_pos, graph, part2 = true)[1]
        .reduce(Set[]){|acc, path|
            acc | path.each_cons(2).flat_map{ get_traversed_positions(*_1, *_2) }
        }.size
    end

  end
end
