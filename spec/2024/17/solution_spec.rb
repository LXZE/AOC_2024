# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Year2024::Day17 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), "../../../challenges/2024/17/input.txt")) }
  let(:example_input) {
    <<~EOF
Register A: 729
Register B: 0
Register C: 0

Program: 0,1,5,4,3,0
    EOF
  }
  let(:example_input2) {
    <<~EOF
Register A: 2024
Register B: 0
Register C: 0

Program: 0,3,5,4,3,0
    EOF
  }

  describe "part 1" do
    it "returns nil for the example input" do
      expect(described_class.part_1(example_input)).to eq('4,6,3,5,6,3,5,2,1,0')
    end

  end

  describe "part 2" do
    # it "returns nil for the example input" do
    #   expect(described_class.part_2(example_input2)).to eq(117440)
    # end
  end
end
