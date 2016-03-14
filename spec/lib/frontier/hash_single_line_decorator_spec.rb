require 'spec_helper'

describe Frontier::HashSingleLineDecorator do

  let(:decorator) { Frontier::HashSingleLineDecorator.new(hash) }

  describe "#to_s" do
    subject { decorator.to_s }
    let(:hash) do
      {
        a: 1,
        "b" => :a_symbol,
        c: {d: "some_string"},
        e: {f: {"g" => 4}}
      }
    end

    it "decorates the hash" do
      should eq("a: 1, b: :a_symbol, c: {d: \"some_string\"}, e: {f: {g: 4}}")
    end
  end

end
