require 'spec_helper'

describe Frontier::FeatureSpecAssignment do

  describe "#to_s" do
    subject { Frontier::FeatureSpecAssignment.new(attribute_or_association).to_s }
    let(:name)        { "association_name" }
    let(:options)     { {} }

    context "when association" do
      let(:attribute_or_association) { Frontier::Association.new(build_model, name, options) }

      it "delegates to Frontier::Association::FeatureSpecAssignment" do
        expect_any_instance_of(Frontier::Association::FeatureSpecAssignment).to receive(:to_s)
        subject
      end
    end

    context "when attribute" do
      let(:attribute_or_association) { Frontier::Attribute.new(build_model, name, options) }

      it "delegates to Frontier::Attribute::FeatureSpecAssignment" do
        expect_any_instance_of(Frontier::Attribute::FeatureSpecAssignment).to receive(:to_s)
        subject
      end
    end
  end

end
