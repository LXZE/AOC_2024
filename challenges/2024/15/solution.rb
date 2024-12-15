# frozen_string_literal: true
module Year2024
  class Day15 < Solution

    require 'matrix'

    def parse_data
      data.chunk{_1 == ''}.to_a.reject{_1[0]}.map{_2}
    end

    def debug(pos, boxes, walls)
      for r in 0...$limit_r
        line = ''
        for c in 0...$limit_c
          line += if walls.member? [r,c] then '#'
          elsif boxes.member? [r,c] then 'O'
          elsif [r,c] == pos then '@'
          else '.'
          end
        end
        puts line
      end
      puts ''
    end

    def search_moveable_box(r, c, cmd, boxes, walls)
      case cmd
      when '<'
        cs = (c-1).downto(0).take_while{boxes.member? [r, _1]}
        return [], walls.member?([r, c-1]) if cs.size == 0
        (cs.size > 0 and walls.member? [r, cs[-1]-1]) ? [[], true] : [cs.map{[r, _1]}, false]
      when '>'
        cs = ((c+1)...$limit_c).take_while{boxes.member? [r, _1]}
        return [], walls.member?([r, c+1]) if cs.size == 0
        (cs.size > 0 and walls.member? [r, cs[-1]+1]) ? [[], true] : [cs.map{[r, _1]}, false]
      when '^'
        rs = (r-1).downto(0).take_while{boxes.member? [_1, c]}
        return [], walls.member?([r-1, c]) if rs.size == 0
        (rs.size > 0 and walls.member? [rs[-1]-1, c]) ? [[], true] : [rs.map{[_1, c]}, false]
      when 'v'
        rs = ((r+1)...$limit_r).take_while{boxes.member? [_1, c]}
        return [], walls.member?([r+1, c]) if rs.size == 0
        (rs.size > 0 and walls.member? [rs[-1]+1, c]) ? [[], true] : [rs.map{[_1, c]}, false]
      end
    end

    def move_boxes_by_cmds(r, c, cmds, boxes, walls)
      for cmd in cmds.chars
        to_move_boxes, stuck = search_moveable_box(r, c, cmd, boxes, walls)
        boxes -= to_move_boxes
        case cmd
        when '<' then if to_move_boxes.size > 0 or not stuck
          to_move_boxes.map!{[_1, _2-1]}; c -= 1 end
        when '>' then if to_move_boxes.size > 0 or not stuck
          to_move_boxes.map!{[_1, _2+1]}; c += 1 end
        when '^' then if to_move_boxes.size > 0 or not stuck
          to_move_boxes.map!{[_1-1, _2]}; r -= 1 end
        when 'v' then if to_move_boxes.size > 0 or not stuck
          to_move_boxes.map!{[_1+1, _2]}; r += 1 end
        end
        boxes |= to_move_boxes
        # debug([r, c], boxes, walls)
      end
      boxes
    end

    def part_1
      map, cmds = parse_data
      $limit_r, $limit_c = map.size, map[0].size
      map = Matrix[*map.map(&:chars)]
      cmds = cmds.join

      robot_pos = map.index '@'
      walls = Set[]
      boxes = Set[]
      for r in 0...$limit_r
        for c in 0...$limit_c
          case map[r, c]
          when '#' then walls.add([r,c])
          when 'O' then boxes.add([r,c])
          end
        end
      end
      boxes = move_boxes_by_cmds(*robot_pos, cmds, boxes, walls)
      boxes.sum{(_1*100) + _2}
    end

    def upgrade_map(map)
      map.map{|row|
        row.flat_map{
          case _1
          when '#' then '##'
          when 'O' then '[]'
          when '.' then '..'
          when '@' then '@.'
          end
        }.join.chars
      }
    end

    def debug_widebox(pos, boxes, walls)
      for r in 0...$limit_r
        line = ''
        for c in 0...$limit_c
          line += if walls.member? [r,c] then '#'
          elsif boxes.member? [r, c, c+1] then '['
          elsif boxes.member? [r, c-1, c] then ']'
          elsif [r,c] == pos then '@'
          else '.'
          end
        end
        puts line
      end
      puts ''
    end

    def search_moveable_widebox(r, c, cmd, boxes, walls)
      case cmd
      when '<' # check from right position, cs = col of right part
        cs = (c-1).step(to: 0, by: -2).take_while{boxes.member? [r, _1-1, _1]}
        return [], walls.member?([r, c-1]) if cs.size == 0
        (cs.size > 0 and walls.member? [r, cs[-1]-2]) ? [[], true] : [cs.map{[r, _1-1, _1]}, false]

      when '>'  # check from left position, cs = col of left part
        cs = (c+1).step(to: $limit_c-1, by: 2).take_while{boxes.member? [r, _1, _1+1]}
        return [], walls.member?([r, c+1]) if cs.size == 0
        (cs.size > 0 and walls.member? [r, cs[-1]+2]) ? [[], true] : [cs.map{[r, _1, _1+1]}, false]

      when '^' # check previous row iteratively if that row has stuck or not
        cdd = Set[[r-1, c, c+1], [r-1, c-1, c]]
        return [], walls.member?([r-1, c]) if not boxes.intersect?(cdd)
        result = []
        while boxes.intersect?(cdd)
          cdd = boxes & cdd
          return [], true if cdd.flat_map{[_2, _3]}.any?{walls.member? [r-2, _1]}
          r -= 1
          result.push(*cdd.to_a)
          cdd = Set[*cdd.flat_map{[[_1-1, _2, _3], [_1-1, _2-1, _3-1], [_1-1, _2+1, _3+1]]}]
        end
        [result, false]

      when 'v' # check next row
        cdd = Set[[r+1, c, c+1], [r+1, c-1, c]]
        return [], walls.member?([r+1, c]) if not boxes.intersect?(cdd)
        result = []
        while boxes.intersect?(cdd)
          cdd = boxes & cdd
          return [], true if cdd.flat_map{[_2, _3]}.any?{walls.member? [r+2, _1]}
          r += 1
          result.push(*cdd.to_a)
          cdd = Set[*cdd.flat_map{[[_1+1, _2, _3], [_1+1, _2-1, _3-1], [_1+1, _2+1, _3+1]]}]
        end
        [result, false]
      end
    end

    def move_wideboxes_by_cmds(r, c, cmds, boxes, walls)
      for cmd, _idx in cmds.chars.each_with_index
        to_move_boxes, stuck = search_moveable_widebox(r, c, cmd, boxes, walls)
        # p [_idx, cmd, [r,c], to_move_boxes, stuck]
        boxes -= to_move_boxes
        case cmd
        when '<' then if to_move_boxes.size > 0 or not stuck
          to_move_boxes.map!{[_1, _2-1, _3-1]}; c -= 1; end
        when '>' then if to_move_boxes.size > 0 or not stuck
          to_move_boxes.map!{[_1, _2+1, _3+1]}; c += 1; end
        when '^' then if to_move_boxes.size > 0 or not stuck
          to_move_boxes.map!{[_1-1, _2, _3]}; r -= 1; end
        when 'v' then if to_move_boxes.size > 0 or not stuck
          to_move_boxes.map!{[_1+1, _2, _3]}; r += 1; end
        end
        boxes |= to_move_boxes
        # debug_widebox([r, c], boxes, walls)
      end
      boxes
    end

    def part_2
      map, cmds = parse_data
      map = Matrix[*upgrade_map(map.map(&:chars))]
      $limit_r, $limit_c = map.row_count, map.column_count
      cmds = cmds.join

      robot_pos = map.index '@'
      walls = Set[]
      boxes = Set[]
      for r in 0...$limit_r
        for c in 0...$limit_c
          case map[r, c]
          when '#' then walls.add([r,c])
          when '[' then boxes.add([r,c, c+1])
          end
        end
      end
      boxes = move_wideboxes_by_cmds(*robot_pos, cmds, boxes, walls)
      boxes.sum{(_1*100) + _2}
    end

  end
end
