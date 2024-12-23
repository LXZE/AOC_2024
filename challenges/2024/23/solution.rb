# frozen_string_literal: true
module Year2024
  class Day23 < Solution

    def parse_data
      data.map{_1.split('-')}
    end

    def part_1
      conns = parse_data
      lookup_conn = conns.reduce(Hash.new{|h,k| h[k] = Set.new}){|acc, (a, b)|
        acc[a].add(b); acc[b].add(a); acc
      }

      lookup_conn.keys.combination(2).filter_map{|k1,k2|
        inter_conn = (lookup_conn[k1]).intersection(lookup_conn[k2])
        if lookup_conn[k1] === k2 and lookup_conn[k2] === k1 and inter_conn.size > 0
          inter_conn.map{|conn| Set[k1,k2,conn]}
        end
      }
        .flatten.reduce(Set[]){|acc, conn| acc << conn}
        .count{|set|set.any? {_1[0] == ?t} }
    end

    def part_2
      conns = parse_data
      lookup_conn = conns.reduce(Hash.new{|h,k| h[k] = Set.new}){|acc, (a, b)|
        acc[a].add(b); acc[b].add(a); acc
      }

      lookup_conn.keys.combination(2).filter_map{|k1,k2|
        inter_conn = (lookup_conn[k1] | [k1]).intersection(lookup_conn[k2] | [k2])
        intersect_result = inter_conn.map{|node| lookup_conn[node] | [node]}
          .reduce{|acc, set| acc.intersection(set)}
        inter_conn if inter_conn == intersect_result and inter_conn.size > 3
      }.reduce(Set[]){|acc, conn| acc << conn}.max_by(&:size).to_a.sort.join(',')
    end

  end
end
