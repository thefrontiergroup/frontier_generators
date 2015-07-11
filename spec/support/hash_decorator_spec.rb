require 'spec_helper'

describe Frontier::HashDecorator do

  let(:decorator) { Frontier::HashDecorator.new(hash) }

  describe "#to_s" do
    subject { decorator.to_s }
    let(:hash) do
      {
        a: 1,
        "b" => 2,
        c: {d: "some_string"},
        e: {f: {"g" => 4}}
      }
    end

    it "decorates the hash" do
      should eq("a: 1, b: 2, c: {d: \"some_string\"}, e: {f: {g: 4}}")
    end
  end

end