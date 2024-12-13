# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Year2024::Day13 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), "../../../challenges/2024/13/input.txt")) }
  let(:example_input) {
    <<~EOF
Button A: X+94, Y+34
Button B: X+22, Y+67
Prize: X=8400, Y=5400

Button A: X+26, Y+66
Button B: X+67, Y+21
Prize: X=12748, Y=12176

Button A: X+17, Y+86
Button B: X+84, Y+37
Prize: X=7870, Y=6450

Button A: X+69, Y+23
Button B: X+27, Y+71
Prize: X=18641, Y=10279
    EOF
  }

  describe "part 1" do
    it "returns nil for the example input" do
      expect(described_class.part_1(example_input)).to eq(480)
    end

  end

  describe "part 2" do
    it "returns nil for the example input" do
      expect(described_class.part_2(example_input)).to eq(875318608908)
    end

  end
end
