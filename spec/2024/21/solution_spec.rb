# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Year2024::Day21 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), "../../../challenges/2024/21/input.txt")) }
  let(:example_input) {
    <<~EOF
029A
980A
179A
456A
379A
    EOF
  }

  describe "part 1" do
    it "returns nil for the example input" do
      expect(described_class.part_1(example_input)).to eq(126384)
    end
  end

  describe "part 2" do
    it "returns nil for the example input" do
      expect(described_class.part_2(example_input)).to eq(154115708116294)
    end
  end

end
