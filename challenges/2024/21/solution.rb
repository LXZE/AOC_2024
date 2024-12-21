# frozen_string_literal: true

=begin
numeral keypad
+---+---+---+
| 7 | 8 | 9 |
+---+---+---+
| 4 | 5 | 6 |
+---+---+---+
| 1 | 2 | 3 |
+---+---+---+
    | 0 | A |
    +---+---+

directional keypad
    +---+---+
    | ^ | A |
+---+---+---+
| < | v | > |
+---+---+---+
=end

module Year2024
  class Day21 < Solution

    def parse_data
        data.map{[_1.chars, _1.scan(/\d+/).map(&:to_i)[0]]}
    end

    $get_next_numeral = {
      ?A => [[?0, ?<], [?3, ?^]],
      ?0 => [[?2, ?^], [?A, ?>]],
      ?1 => [[?2, ?>], [?4, ?^]],
      ?2 => [[?1, ?<], [?0, ?v], [?3, ?>], [?5, ?^]],
      ?3 => [[?2, ?<], [?A, ?v], [?6, ?^]],
      ?4 => [[?1, ?v], [?5, ?>], [?7, ?^]],
      ?5 => [[?2, ?v], [?4, ?<], [?6, ?>], [?8, ?^]],
      ?6 => [[?3, ?v], [?5, ?<], [?9, ?^]],
      ?7 => [[?4, ?v], [?8, ?>]],
      ?8 => [[?5, ?v], [?7, ?<], [?9, ?>]],
      ?9 => [[?6, ?v], [?8, ?<]],
    }
    $get_next_directional = {
      ?A => [[?^, ?<], [?>, ?v]],
      ?^ => [[?A, ?>], [?v, ?v]],
      ?< => [[?v, ?>]],
      ?v => [[?<, ?<], [?^, ?^], [?>, ?>]],
      ?> => [[?A, ?^], [?v, ?<]],
    }

    def get_paths(start, target, lookup)
      cdd = [{path: [start], action: []}]
      until cdd.any?{_1[:path][-1] == target}
        cdd = cdd.flat_map{|entry|
          entry => {path:, action:}
          lookup[path[-1]].map{|next_val, act|
            {path: path + [next_val], action: action + [act]}
          }
        }
      end
      # must press A at the end
      cdd.filter_map{_1[:action] + [?A] if _1[:path][-1] == target}
    end

    def create_directional_lookup
      Hash.new([[?A]]).merge( # default = [[?A]] (press A) when start == target
        %w[^ < v > A].permutation(2).map{|start, target|
          [[start, target], get_paths(start, target, $get_next_directional)]
        }.to_h)
    end

    $level_cache = {}
    def calculate_path_size(path, level, target_level)
      return path.size if level == target_level

      [?A].concat(path).each_cons(2)
        .sum{|start, target|
          if $level_cache.has_key? [start, target, level]
            $level_cache[[start, target, level]]
          else
            $level_cache[[start, target, level]] = \
            $directional_lookup[[start, target]].map{|next_path|
              calculate_path_size(next_path, level + 1, target_level)
            }.min
          end
        }
    end

    def solve(deep)
      $level_cache = {} # must reset when target level change
      cmds = parse_data
      cmds.sum{|cmd, val|
        cmd.unshift(?A).each_cons(2)
          .map{|start, target| get_paths(start, target, $get_next_numeral)}
          .reduce{|acc, sub_path| acc.product(sub_path).map{_1 + _2}}
          .map{|cmd| calculate_path_size(cmd, 0, deep)}.min * val
      }
    end

    def part_1
      $directional_lookup = create_directional_lookup
      solve(2)
    end

    def part_2
      solve(25)
    end

  end
end
