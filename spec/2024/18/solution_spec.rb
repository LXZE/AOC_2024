# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Year2024::Day18 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), "../../../challenges/2024/18/input.txt")) }
  let(:example_input) {
    <<~EOF
5,4
4,2
4,5
3,0
2,1
6,3
2,4
1,5
0,6
3,3
2,6
5,1
1,2
5,5
2,5
6,5
1,4
0,4
6,4
1,1
6,1
1,0
0,5
1,6
2,0
    EOF
  }

  describe "part 1" do
    it "returns nil for the example input" do
      expect(described_class.part_1(example_input)).to eq(22)
    end

  end

  describe "part 2" do
    it "returns nil for the example input" do
      expect(described_class.part_2(example_input)).to eq('6,1')
    end

  end
end
