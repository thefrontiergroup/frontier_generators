require 'spec_helper'

describe Frontier::Attribute::Constant do

  describe ".build_from_validation" do
    subject(:constant)   { Frontier::Attribute::Constant.build_from_validation(attribute, validation) }

    let(:attribute)  { Frontier::Attribute.new(build_model_configuration, name, options) }
    let(:name)       { "field_name" }
    let(:options)    { {} }
    let(:validation) { Frontier::Attribute::Validation.new(attribute, "inclusion", [1,2,3]) }

    it "builds a Constant" do
      expect(constant.name).to eq("TestModel::FIELD_NAME_VALUES")
      expect(constant.values).to eq([1, 2, 3])
    end

  end

  describe "#model_implementation" do
    subject { constant.model_implementation }

    let(:constant)   { Frontier::Attribute::Constant.build_from_validation(attribute, validation) }
    let(:attribute)  { Frontier::Attribute.new(build_model_configuration, name, options) }
    let(:name)       { "field_name" }
    let(:options)    { {} }
    let(:validation) { Frontier::Attribute::Validation.new(attribute, "inclusion", [1,2,3]) }

    it { should eq("FIELD_NAME_VALUES = [1, 2, 3].map(&:freeze).freeze") }
  end
end
