require 'spec_helper'

describe ModelConfiguration::Attribute do

  let(:attribute) { ModelConfiguration::Attribute.new(name, options) }
  let(:name) { "attribute_name" }
  let(:options) { {} }

  describe "#as_enum" do
    subject { attribute.as_enum }

    context "when field is not an enum" do
      let(:options) { {type: "string"} }
      specify { expect { subject }.to raise_error(ArgumentError) }
    end

    context "when field is an enum" do
      let(:options) { {type: "enum", enum_options: ["one", "two"]} }
      it { should eq("enum attribute_name: [\"one\", \"two\"]") }
    end
  end

  describe "#is_association?" do
    subject { attribute.is_association? }
    it { should eq(false) }
  end

  describe "#is_enum?" do
    subject { attribute.is_enum? }

    context "when field is not an enum" do
      let(:options) { {type: "string"} }
      it { should eq(false) }
    end

    context "when field is an enum" do
      let(:options) { {type: "enum", enum_options: ["one", "two"]} }
      it { should eq(true) }
    end
  end

end