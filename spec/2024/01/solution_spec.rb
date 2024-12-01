# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Year2024::Day01 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), "../../../challenges/2024/01/input.txt")) }
  let(:example_input) {
    <<~EOF
3   4
4   3
2   5
1   3
3   9
3   3
    EOF
  }

  describe "part 1" do
    it "returns nil for the example input" do
      expect(described_class.part_1(example_input)).to eq(11)
    end
  end

  describe "part 2" do
    it "returns nil for the example input" do
      expect(described_class.part_2(example_input)).to eq(31)
    end
  end
end
