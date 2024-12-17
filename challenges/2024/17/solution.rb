# frozen_string_literal: true
module Year2024
  class Day17 < Solution

    def parse_data
      regs, code = data.chunk{_1 == ''}.to_a.reject{_1[0]}.map(&:last)
      regs = regs.map{_1.split(': ')[1].to_i}
      code = code[0].split(': ')[1].split(',').map(&:to_i)
      a,b,c = regs
      [{a: ,b:, c:}, code]
    end

    def get_value(regs, val)
      case val
      in 0..3 then val
      in 4 then regs[:a]
      in 5 then regs[:b]
      in 6 then regs[:c]
      in 7 then raise 'Reserved value'
      end
    end

    def run(regs, code)
      pc = 0
      output = []
      while pc < code.size
        literal_operand = code[pc+1]
        combo_operand = get_value(regs, code[pc+1])
        case code[pc]
        when 0 # adv = div with combo then A
          regs[:a] = regs[:a] / (2**combo_operand)
        when 1 # bxl = XOR with literal then B
          regs[:b] ^= literal_operand
        when 2 # bst = mod with combo then B
          regs[:b] = combo_operand % 8
        when 3 # jnz = jump if not zero or +2
          if regs[:a] != 0
            pc = literal_operand
            next
          end
        when 4 # bxc = XOR with with C then B
          regs[:b] ^= regs[:c]
        when 5 # out = print to output with combo
          output << combo_operand % 8
        when 6 # bdv = div with combo then B
          regs[:b] = regs[:a] / (2**combo_operand)
        when 7 # cdv = div with combo then C
          regs[:c] = regs[:a] / (2**combo_operand)
        end
        pc += 2
      end
      output
    end

    def part_1
      regs, code = parse_data
      run(regs, code).join(',')
    end

    def find_output(a) # input specific
      # is it possible to convert from code to these formula automatically? :thinking:
      b = (a % 8) ^ 3
      c = a >> b
      ((b ^ 5) ^ c) % 8
    end

    def part_2
      regs, code = parse_data
      possible_as = [0] # Program stop when reg:a == 0

      code.reverse.each{|current_code| # calculate backward from the given code
        possible_as = possible_as.product((0..7).to_a).filter_map{|a, i|
          new_a = (a << 3) + i # reverse a = a >> 3 and find variants in +0..7
          b = find_output(new_a)
          new_a if b == current_code
        }
      }

      possible_as.min
      # regs[:a] = possible_as.min
      # res = run(regs, code)
      # print(res == code)
    end

  end
end

=begin
2,4 == reg:b = reg:a % 8
1,3 == reg:b = reg:b ^ 3
7,5 == reg:c = reg:a / (2**reg:b)
1,5 == reg:b = reg:b ^ 5
0,3 == reg:a = reg:a / 8
4,1 == reg:b = reg:b ^ reg:c
5,5 == print reg:b % 8
3,0 == if reg:a != 0 JUMP to 0 again
===============================================
b = a % 8
b ^= 3
c = a/2**b  # c = a >> b
b ^= 5
a /= 8      # a = a >> 3
b ^= c
print(b)
if a != 0 goto 0
===============================================
b = (a % 8) ^ 3
c = a >> b
print((b ^ 5) ^ c % 8)
=end
