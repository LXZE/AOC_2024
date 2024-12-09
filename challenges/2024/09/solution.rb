# frozen_string_literal: true
module Year2024
  class Day09 < Solution

    def remove_dots(lst)
      while lst.last == '.' do lst = lst[...-1] end
      lst
    end

    def defrag(lst)
      lst = remove_dots(lst)
      pointer_l = 0
      pointer_r = lst.size - 1
      while pointer_l < pointer_r
        if lst[pointer_l] == '.'
          lst[pointer_l] = lst[pointer_r]
          lst = remove_dots(lst[...-1])
          pointer_l += 1
          pointer_r = lst.size - 1
        else pointer_l += 1 end
      end
      lst
    end

    def part_1
      disk = data.chars.map(&:to_i).reduce([[], 0, :num]) {|acc, num|
        acc => [res, num_state, file_state]
        case file_state
        when :num then [res.push(*([num_state] * num)), num_state+1, :dot]
        when :dot then [res.push(*(['.'] * num)),       num_state, :num]
        end
      }[0]
      defrag(disk).each_with_index.reduce(0){ |acc, val|
        val => [num, idx]; acc + (num*idx)
      }
    end

    def defrag_files(lookup_table, space_pos)
      inf = Float::INFINITY
      new_disk = Array.new(lookup_table.size + space_pos.size){Array.new}

      current_id = lookup_table.keys.max
      while current_id >= 0
        from_index, file_size = lookup_table[current_id]
        to_index, space_size = space_pos.find(->{[inf, 0]}) {|_, space_size|
          space_size >= file_size
        }
        # p [current_id, from_index, file_size, to_index, space_size]
        if to_index < from_index # can insert to space
          # move file to new idx
          new_disk[to_index].push(*[current_id]*file_size)
          # current pos become space, use for merging
          space_pos[from_index] = file_size

          if (space_size - file_size) == 0
            space_pos.delete(to_index) # target space is fully occupied
          else
            space_pos[to_index] -= file_size
          end
        else # otherwise, just move entire file to new_disk
          new_disk[from_index].push(*[current_id]*file_size)
        end
        current_id -= 1
      end
      [new_disk, space_pos]
    end

    def part_2
      disk = data.chars.map(&:to_i).reduce([[], 0, :num]) {|acc, num|
        acc => [res, num_state, file_state]
        case file_state
        when :num then [res.push(([num_state, num])), num_state+1, :dot]
        when :dot then [res.push((['.', num])),       num_state, :num]
        end
      }[0].reject{_1.size == 0}

      lookup_table = {}
      space_pos = {}
      for entry, idx in disk.each_with_index
        entry => [id, size]
        if id == '.' then space_pos[idx] = size if size > 0
        else lookup_table[id] = [idx, size] end
      end

      disk, space_pos = defrag_files(lookup_table, space_pos)
      disk.each_with_index.reduce([]){|acc, entry|
        entry => [val, idx]
        acc.push(*val, *(space_pos.has_key?(idx) ? ['.']*space_pos[idx] : []))
      }.each_with_index.reduce(0){|acc, val|
        val => [num, idx]; num == '.' ? acc : acc + (num*idx)
      }
    end

  end
end
