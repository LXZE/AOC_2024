# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Year2024::Day10 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), "../../../challenges/2024/10/input.txt")) }
  let(:example_input) {
    <<~EOF
89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732
    EOF
  }
  let(:test_input) {
    <<~EOF
012345
123456
234567
345678
4.6789
56789.
    EOF
  }

  describe "part 1" do
    it "returns nil for the example input" do
      expect(described_class.part_1(example_input)).to eq(36)
    end
  end

  describe "part 2" do
    it "returns nil for the example input" do
      expect(described_class.part_2(test_input)).to eq(227)
      expect(described_class.part_2(example_input)).to eq(81)
    end
  end
end
