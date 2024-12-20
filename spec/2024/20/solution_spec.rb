# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Year2024::Day20 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), "../../../challenges/2024/20/input.txt")) }
  let(:example_input) {
    <<~EOF
###############
#...#...#.....#
#.#.#.#.#.###.#
#S#...#.#.#...#
#######.#.#.###
#######.#.#...#
#######.#.###.#
###..E#...#...#
###.#######.###
#...###...#...#
#.#####.#.###.#
#.#...#.#.#...#
#.#.#.#.#.#.###
#...#...#...###
###############
    EOF
  }

  describe "part 1" do
    it "returns nil for the example input" do
      expect(described_class.part_1(example_input)).to eq(44)
    end
  end

  describe "part 2" do
    it "returns nil for the example input" do
      expect(described_class.part_2(example_input)).to eq(285)
    end
  end
end
