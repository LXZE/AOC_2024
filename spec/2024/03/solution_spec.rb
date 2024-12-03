# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Year2024::Day03 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), "../../../challenges/2024/03/input.txt")) }
  let(:example_input) {
    <<~EOF
      xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))

    EOF
  }

  let(:example_input2) {
    <<~EOF
      xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))

    EOF
  }


  describe "part 1" do
    it "returns nil for the example input" do
      expect(described_class.part_1(example_input)).to eq(161)
    end
  end

  describe "part 2" do
    it "returns nil for the example input" do
      expect(described_class.part_2(example_input2)).to eq(48)
    end
  end
end
