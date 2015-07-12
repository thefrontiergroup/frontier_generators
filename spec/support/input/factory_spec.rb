require 'spec_helper'

describe Frontier::Input::Factory do

  describe ".build_for" do
    subject { Frontier::Input::Factory.build_for(instance) }

    context "when instance is a ModelConfiguration::Association" do
      let(:instance) { ModelConfiguration::Association.new(nil, nil, {}) }
      it "returns a Frontier::Input::Association" do
        expect(subject).to be_kind_of(Frontier::Input::Association)
      end
    end

    context "when instance is a ModelConfiguration::Attribute" do
      let(:instance) { ModelConfiguration::Attribute.new(nil, nil, {}) }
      it "returns a Frontier::Input::Attribute" do
        expect(subject).to be_kind_of(Frontier::Input::Attribute)
      end
    end

    context "when instance is something else" do
      let(:instance) { "YOLO!" }
      it "raises an ArgumentError" do
        expect { subject }.to raise_exception(ArgumentError)
      end
    end

  end

end