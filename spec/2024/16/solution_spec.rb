# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Year2024::Day16 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), "../../../challenges/2024/16/input.txt")) }
  let(:example_input1) {
    <<~EOF
###############
#.......#....E#
#.#.###.#.###.#
#.....#.#...#.#
#.###.#####.#.#
#.#.#.......#.#
#.#.#####.###.#
#...........#.#
###.#.#####.#.#
#...#.....#.#.#
#.#.#.###.#.#.#
#.....#...#.#.#
#.###.#.#.#.#.#
#S..#.....#...#
###############
    EOF
  }
  let(:example_input2) {
    <<~EOF
#################
#...#...#...#..E#
#.#.#.#.#.#.#.#.#
#.#.#.#...#...#.#
#.#.#.#.###.#.#.#
#...#.#.#.....#.#
#.#.#.#.#.#####.#
#.#...#.#.#.....#
#.#.#####.#.###.#
#.#.#.......#...#
#.#.###.#####.###
#.#.#...#.....#.#
#.#.#.#####.###.#
#.#.#.........#.#
#.#.#.#########.#
#S#.............#
#################
    EOF
  }

  describe "part 1" do
    it "returns nil for the example input" do
      expect(described_class.part_1(example_input1)).to eq(7036)
      expect(described_class.part_1(example_input2)).to eq(11048)
    end
  end

  describe "part 2" do
    it "returns nil for the example input" do
      expect(described_class.part_2(example_input1)).to eq(45)
      expect(described_class.part_2(example_input2)).to eq(64)
    end
  end
end
