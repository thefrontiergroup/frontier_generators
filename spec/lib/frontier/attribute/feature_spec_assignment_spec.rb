require 'spec_helper'

describe Frontier::Attribute::FeatureSpecAssignment do

  describe "#to_s" do
    subject { Frontier::Attribute::FeatureSpecAssignment.new(attribute).to_s }
    let(:attribute)  { Frontier::Attribute.new(build_model, name, options) }
    let(:name)       { "attribute_name" }
    let(:options)    { {type: attribute_type} }

    context "when attribute_type"

    context "when boolean" do
      let(:attribute_type) { :boolean }
      it { should eq('check("Attribute name")') }
    end

    [:date, :datetime, :decimal, :integer, :string, :text].each do |attribute_type|
      context "when #{attribute_type}" do
        let(:attribute_type) { attribute_type }
        it { should eq('fill_in("Attribute name", with: attributes[:attribute_name])') }
      end
    end

    context "when enum" do
      let(:attribute_type) { :enum }
      it { should eq('select(attributes[:attribute_name], from: "Attribute name")') }
    end
  end

end
