require 'spec_helper'

describe Frontier::HashMultilineDecorator do

  let(:decorator) { Frontier::HashMultilineDecorator.new(hash) }

  describe "#to_s" do
    subject { decorator.to_s }
    let(:hash) do
      {
        a: 1,
        "b" => 2,
        c: {d: "some_object"},
        e: {f: {"g" => '"some_string"'}}
      }
    end
    let(:expected) do
      raw = <<-STRING
{
  a: 1,
  b: 2,
  c: {
    d: some_object
  },
  e: {
    f: {
      g: "some_string"
    }
  }
}
      STRING
      raw.rstrip
    end

    it "decorates the hash" do
      should eq(expected)
    end
  end

end
