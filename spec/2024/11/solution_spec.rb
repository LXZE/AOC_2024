# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Year2024::Day11 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), "../../../challenges/2024/11/input.txt")) }
  let(:example_input) {
    <<~EOF
125 17
    EOF
  }

  describe "part 1" do
    it "returns nil for the example input" do
      expect(described_class.part_1(example_input)).to eq(55312)
    end
  end

  describe "part 2" do
    it "returns nil for the example input" do
      expect(described_class.part_2(example_input)).to eq(65601038650482)
    end
  end
end
