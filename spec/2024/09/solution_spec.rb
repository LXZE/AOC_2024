# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Year2024::Day09 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), "../../../challenges/2024/09/input.txt")) }
  let(:example_input) {
    <<~EOF
2333133121414131402
    EOF
  }

  describe "part 1" do
    it "returns nil for the example input" do
      expect(described_class.part_1(example_input)).to eq(1928)
    end
  end

  describe "part 2" do
    it "returns nil for the example input" do
      expect(described_class.part_2(example_input)).to eq(2858)
    end
  end
end
