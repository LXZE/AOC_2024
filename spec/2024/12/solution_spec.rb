# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Year2024::Day12 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), "../../../challenges/2024/12/input.txt")) }
  let(:example_input1) {
    <<~EOF
AAAA
BBCD
BBCC
EEEC
    EOF
  }
  let(:example_input2) {
    <<~EOF
OOOOO
OXOXO
OOOOO
OXOXO
OOOOO
    EOF
  }
  let(:example_input3) {
    <<~EOF
RRRRIICCFF
RRRRIICCCF
VVRRRCCFFF
VVRCCCJFFF
VVVVCJJCFE
VVIVCCJJEE
VVIIICJJEE
MIIIIIJJEE
MIIISIJEEE
MMMISSJEEE
    EOF
  }
  let(:example_input4) {
    <<~EOF
EEEEE
EXXXX
EEEEE
EXXXX
EEEEE
    EOF
  }
  let(:example_input5) {
    <<~EOF
AAAAAA
AAABBA
AAABBA
ABBAAA
ABBAAA
AAAAAA
    EOF
  }

  describe "part 1" do
    it "returns nil for the example input" do
      expect(described_class.part_1(example_input1)).to eq(140)
      expect(described_class.part_1(example_input2)).to eq(772)
      expect(described_class.part_1(example_input3)).to eq(1930)
    end
  end

  describe "part 2" do
    it "returns nil for the example input" do
      expect(described_class.part_2(example_input1)).to eq(80)
      expect(described_class.part_2(example_input2)).to eq(436)
      expect(described_class.part_2(example_input3)).to eq(1206)
      expect(described_class.part_2(example_input4)).to eq(236)
      expect(described_class.part_2(example_input5)).to eq(368)
    end
  end
end
