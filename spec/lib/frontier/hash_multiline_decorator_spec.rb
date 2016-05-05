require 'spec_helper'

describe Frontier::HashMultilineDecorator do

  let(:decorator) { Frontier::HashMultilineDecorator.new(hash) }

  describe "#to_s" do
    let(:hash) do
      {
        a: 1,
        "b" => 2,
        c: {d: "some_object"},
        e: {f: {"g" => '"some_string"'}}
      }
    end

    context "without an indent level provided" do
      subject { decorator.to_s }
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

    context "with an indent level provided" do
      subject { decorator.to_s(1) }
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

end
