# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Year2024::Day08 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), "../../../challenges/2024/08/input.txt")) }
  let(:simple_input) {
    <<~EOF
..........
..........
..........
....a.....
..........
.....a....
..........
..........
..........
..........
    EOF
  }
  let(:example_input) {
    <<~EOF
............
........0...
.....0......
.......0....
....0.......
......A.....
............
............
........A...
.........A..
............
............
    EOF
  }
  let(:simple_input2) {
    <<~EOF
T.........
...T......
.T........
..........
..........
..........
..........
..........
..........
..........
    EOF
  }

  describe "part 1" do
    it "returns nil for the example input" do
      # expect(described_class.part_1(simple_input)).to eq(2)
      expect(described_class.part_1(example_input)).to eq(14)
    end

  end

  describe "part 2" do
    it "returns nil for the example input" do
      expect(described_class.part_2(simple_input2)).to eq(9)
      expect(described_class.part_2(example_input)).to eq(34)
    end

  end
end
