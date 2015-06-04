require 'spec_helper'

describe ModelConfiguration::Attribute::FactoryDeclaration do

  describe "#to_s" do
    subject { ModelConfiguration::Attribute::FactoryDeclaration.new(attribute).to_s }
    let(:attribute) { ModelConfiguration::Attribute.new(name, options) }
    let(:name)      { "field_name" }
    let(:options)   { {type: type} }

    context "type is 'date'" do
      let(:type) { "date" }
      it { should eq("field_name { 5.days.from_now }") }
    end

    context "type is 'datetime'" do
      let(:type) { "datetime" }
      it { should eq("field_name { 5.days.from_now }") }
    end

    context "type is 'enum'" do
      let(:options) { {enum_options: enum_options, type: type} }
      let(:type)    { "enum" }

      context "when enum_options is set" do
        let(:enum_options) { ["one", "two"] }
        it { should eq("field_name { [\"one\", \"two\"].sample }") }
      end

      context "when enum_options is not set" do
        let(:enum_options) { nil }
        specify { expect { subject }.to raise_error(ArgumentError) }
      end
    end

    context "type is 'string'" do
      let(:type) { "string" }

      context "attribute name contains name" do
        let(:name) { "field_name" }
        it { should eq("field_name { FFaker::Name.name }") }
      end

      context "attribute name contains email" do
        let(:name) { "field_email" }
        it { should eq("field_email { FFaker::Internet.email }") }
      end

      context "attribute name contains number" do
        let(:name) { "field_number" }
        it { should eq("field_number { FFaker::PhoneNumberAU.phone_number }") }
      end

      context "attribute name doesn't contain any of the above matches" do
        let(:name) { "field" }
        it { should eq("field { FFaker::Company.bs }") }
      end
    end

    context "type is something else" do
      let(:type) { "heroin" }
      specify { expect { subject }.to raise_error(ArgumentError) }
    end
  end

end