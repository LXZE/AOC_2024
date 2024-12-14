# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Year2024::Day14 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), "../../../challenges/2024/14/input.txt")) }
  let(:example_input) {
    <<~EOF
p=0,4 v=3,-3
p=6,3 v=-1,-3
p=10,3 v=-1,2
p=2,0 v=2,-1
p=0,0 v=1,3
p=3,0 v=-2,-2
p=7,6 v=-1,-3
p=3,0 v=-1,-2
p=9,3 v=2,3
p=7,3 v=-1,2
p=2,4 v=2,-3
p=9,5 v=-3,-3
    EOF
  }

  describe "part 1" do
    it "returns nil for the example input" do
      expect(described_class.part_1(example_input)).to eq(12)
    end

  end

  # describe "part 2" do
  #   it "returns nil for the example input" do
  #     expect(described_class.part_2(example_input)).to eq(nil)
  #   end
  # end
end
