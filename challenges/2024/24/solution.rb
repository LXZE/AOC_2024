# frozen_string_literal: true
module Year2024
  class Day24 < Solution

    require 'parallel'
    require 'algorithms'
    include Containers

    def parse_data
      lookup, graph = data.chunk{_1==''}.to_a.reject{_1[0]}.map{_2}
      [
        lookup.map{_1.split(': ')}.map{[_1, _2.to_i]}.to_h,
        graph.map{_1.scan(/(\w{3}) (AND|OR|XOR) (\w{3}) -> (\w{3})/)[0]}
      ]
    end

    def fill(lookup, graph)
      queue = Queue.new(graph)
      until queue.empty?
        a,op,b,c= queue.pop
        if lookup.has_key?(a) and lookup.has_key?(b)
          lookup[c] = case op
          when 'AND' then lookup[a] & lookup[b]
          when 'OR'  then lookup[a] | lookup[b]
          when 'XOR' then lookup[a] ^ lookup[b]
          end
        else
          queue.push([a, op, b, c])
        end
      end
      lookup
    end

    def part_1
      lookup, graph = parse_data
      lookup = fill(lookup, graph)
      lookup.keys.filter{_1[0] == ?z}.sort.reverse.map{lookup[_1]}.join.to_i(2)
    end

    def gen_key(char, num)
      "#{char}#{num.to_s.rjust(2, '0')}"
    end

    def find_gate(w1,ops,w2)
      $lookup_gates.find{|gate, (a,op,b)|
        [[a,op,b],[b,op,a]].include?([w1,ops,w2])
      }[0]
    end

    def swap_gates(k1, k2)
      $lookup_gates[k1], $lookup_gates[k2] = \
      $lookup_gates[k2], $lookup_gates[k1]
    end

    def part_2
      input_gates, graph = parse_data
      $lookup_gates = graph.map{[_1[3], _1[...3]]}.to_h

      port_amnt = (input_gates.size/2) - 1

      gates_and = Array.new(port_amnt, nil)
      gates_xor = Array.new(port_amnt, nil)
      gates_z = Array.new(port_amnt, nil)
      gates_tmp = Array.new(port_amnt, nil)
      gates_carry = Array.new(port_amnt, nil)

      # gate_and[i]   <= x[i] AND y[i]
      # gate_xor[i]   <= x[i] XOR y[i]
      # gate_z[i]     <= gate_xor[i] XOR gate_carry[i-1]
      # gate_tmp[i]   <= gate_xor[i] AND gate_carry[i-1]
      # gate_carry[i] <= gate_and[i] OR  gate_tmp[i]

      i = 0
      x_key = gen_key(?x, i)
      y_key = gen_key(?y, i)
      gates_and[i] = find_gate(x_key, 'AND', y_key)
      gates_xor[i] = find_gate(x_key, 'XOR', y_key)
      gates_z[i] = gates_xor[i]
      gates_carry[i] = gates_and[i]

      swapped = []
      for i in (1..port_amnt)
        x_key = gen_key(?x, i)
        y_key = gen_key(?y, i)
        z_key = gen_key(?z, i)

        found_swap = false
        begin
          gates_and[i] = find_gate(x_key, 'AND', y_key)
          gates_xor[i] = find_gate(x_key, 'XOR', y_key)

          # p [i, "AND", gates_and[i], "OR", gates_xor[i], "Carry", gates_carry[i-1]]
          # p [$lookup_gates[z_key]]

          in1, ops, in2 = $lookup_gates[z_key]
          # gate_z[i] requires carry[i-1] XOR xor[i]
          if in1 == gates_carry[i-1] and ops == 'XOR' and in2 != gates_xor[i]
            swap_gates(in2, gates_xor[i])
            swapped.push(in2, gates_xor[i])
            found_swap = true
            next
          end
          if in1 != gates_xor[i] and ops == 'XOR' and in2 == gates_carry[i-1]
            swap_gates(in1, gates_xor[i])
            swapped.push(in1, gates_xor[i])
            found_swap = true
            next
          end

          # verify if calculated gate z is correct (==z_key)
          gates_z[i] = find_gate(gates_xor[i], 'XOR', gates_carry[i-1])
          if gates_z[i] != z_key
            # p [gates_z[i]]
            swap_gates(z_key, gates_z[i])
            swapped.push(z_key, gates_z[i])
            found_swap = true
            next
          end

          gates_tmp[i] = find_gate(gates_xor[i], "AND", gates_carry[i - 1])
          gates_carry[i] = find_gate(gates_and[i], "OR", gates_tmp[i])
          found_swap = false
        end until not found_swap
      end

      swapped.sort.join(',')
    end

  end
end
