# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Year2024::Day25 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), "../../../challenges/2024/25/input.txt")) }
  let(:example_input) {
    <<~EOF
#####
.####
.####
.####
.#.#.
.#...
.....

#####
##.##
.#.##
...##
...#.
...#.
.....

.....
#....
#....
#...#
#.#.#
#.###
#####

.....
.....
#.#..
###..
###.#
###.#
#####

.....
.....
.....
#....
#.#..
#.#.#
#####
    EOF
  }

  describe "part 1" do
    it "returns nil for the example input" do
      expect(described_class.part_1(example_input)).to eq(3)
    end

  end
end
