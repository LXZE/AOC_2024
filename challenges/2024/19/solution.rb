# frozen_string_literal: true
module Year2024
  class Day19 < Solution

    require 'parallel'

    def parse_data
      patterns, designs = data.chunk{_1 == ''}.to_a.filter_map{_2 unless _1}
      [Set[*patterns[0].split(', ')], designs]
    end

    $cache = {}
    def find_possible_patterns_count(design, patterns)
      return 1 if design == ''
      return $cache[design] if $cache.has_key?(design)

      $cache[design] = patterns.filter_map{|pattern|
        remain_design = design.sub(Regexp.new("^#{pattern}"), '')
        remain_design if remain_design != design
      }
        .sum{find_possible_patterns_count(_1, patterns)}
    end

    def part_1
      patterns, designs = parse_data
      Parallel.map(designs) { find_possible_patterns_count(_1, patterns) }.count{_1 > 0}
    end

    def part_2
      patterns, designs = parse_data
      Parallel.map(designs) { find_possible_patterns_count(_1, patterns) }.sum
    end

  end
end
