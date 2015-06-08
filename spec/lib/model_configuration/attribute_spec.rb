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

  describe "#validations" do
    subject { attribute.validations }
    let(:options) { {validates: validates} }

    context "when there are no validations specified" do
      let(:validates) { {presence: true} }
      it "constructs a validation object" do
        validation = subject.first
        expect(validation).to be_present
        expect(validation).to be_kind_of(ModelConfiguration::Attribute::Validation)
        expect(validation.attribute).to eq(attribute)
        expect(validation.key).to eq(:presence)
        expect(validation.args).to eq(true)
      end
    end

    context "when there are validations specified" do
      let(:validates) { nil }
      it { should be_empty }
    end

  end

end