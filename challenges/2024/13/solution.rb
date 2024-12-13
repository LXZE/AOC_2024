# frozen_string_literal: true
module Year2024
  class Day13 < Solution

    require 'matrix'
    require 'parallel'

    def parse_data
      data.chunk{_1 == ''}.to_a.reject{_1[0]}
        .map{_1[1].map{|row| row.scan(/\d+/).map(&:to_i)}}
    end

    def search(a, b, target, extra = 10_000_000_000_000)
      ax, ay = a
      bx, by = b
      target_x, target_y = target.map{_1 + extra}

      matrix = Matrix[[ax, bx], [ay, by]]
      target = Vector[target_x, target_y]
      # return 0 if matrix.det == 0
      solution = matrix.inverse * target
      m, n = solution.to_a
      return (3*m + n).to_i if m.denominator == 1 and n.denominator == 1
      return 0
    end

    def part_1
      Parallel.map(parse_data){search(*_1, 0)}.sum
    end

    def part_2
      Parallel.map(parse_data){search(*_1)}.sum
    end

  end
end

# def search(a, b, target)
#   ax, ay = a
#   bx, by = b
#   target_x, target_y = target

#   res = Float::INFINITY
#   for m in 0..100
#     for n in 0..100
#       if ((m*ax)+(n*bx)==target_x) and ((m*ay)+(n*by)==target_y)
#         res = [res, (m*3)+(n)].min
#       end
#     end
#   end
#   res == Float::INFINITY ? 0 : res
# end

# require 'z3'
# include Z3

# def search_large(a, b, target)
#   ax, ay = a
#   bx, by = b
#   target_x, target_y = target.map{_1 + 10_000_000_000_000}
#   solver = Solver.new
#   m = Int "m"
#   n = Int "n"
#   solver.assert m > 0
#   solver.assert n > 0
#   solver.assert (m*ax) + (n*bx) == target_x
#   solver.assert (m*ay) + (n*by) == target_y
#   if solver.satisfiable?
#     result = solver.model.to_h
#     m, n = [m, n].map{result[_1].to_i}
#     return (m * 3) + n
#   else
#     return 0
#   end
# end
