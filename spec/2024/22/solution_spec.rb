# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Year2024::Day22 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), "../../../challenges/2024/22/input.txt")) }
  let(:example_input) {
    <<~EOF
1
10
100
2024
    EOF
  }
  let(:example_input2) {
    <<~EOF
1
2
3
2024
    EOF
  }


  describe "part 1" do
    it "returns nil for the example input" do
      expect(described_class.part_1(example_input)).to eq(37327623)
    end
  end

  describe "part 2" do
    it "returns nil for the example input" do
      expect(described_class.part_2(example_input2)).to eq(23)
    end
  end
end
