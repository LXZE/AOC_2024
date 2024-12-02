# frozen_string_literal: true
module Year2024
  class Day02 < Solution

    def is_safe?(report)
      diff = report.each_cons(2).map {|a, b| a-b}
      if diff.any?(0) || diff.any?{_1.abs > 3} then return false end
      (diff.all?{_1 > 0} or diff.all?{_1 < 0})
    end

    def part_1
      data.map{_1.split(' ').map(&:to_i)}.count{is_safe? _1}
    end

    def gen_deleted_reports(report)
      Array.new(report.size){[*report]}.each_with_index.map{|arr,i| arr.delete_at(i); arr}
    end

    def part_2
      data.map{_1.split(' ').map(&:to_i)} \
        .count{(gen_deleted_reports _1).any?{|new_report| is_safe?(new_report)}}
    end

  end
end
