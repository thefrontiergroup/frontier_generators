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

    context "type is 'decimal'" do
      let(:type) { "decimal" }
      it { should eq("field_name { rand(9999) }") }
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

    context "type is 'integer'" do
      let(:type) { "integer" }
      it { should eq("field_name { rand(9999) }") }
    end

    context "type is 'string'" do
      let(:type) { "string" }

      context "attribute name contains city" do
        let(:name) { "city" }
        it { should eq("city { FFaker::AddressAU.city }") }
      end

      context "attribute name contains email" do
        let(:name) { "field_email" }
        it { should eq("field_email { FFaker::Internet.email }") }
      end

      context "attribute name contains line_1" do
        let(:name) { "line_1" }
        it { should eq("line_1 { FFaker::AddressAU.street_address }") }
      end

      context "attribute name contains line_2" do
        let(:name) { "line_2" }
        it { should eq("line_2 { FFaker::AddressAU.secondary_address }") }
      end

      context "attribute name contains name" do
        let(:name) { "field_name" }
        it { should eq("field_name { FFaker::Name.name }") }
      end

      context "attribute name contains number" do
        let(:name) { "field_number" }
        it { should eq("field_number { FFaker::PhoneNumberAU.phone_number }") }
      end

      context "attribute name contains post_code" do
        let(:name) { "post_code" }
        it { should eq("post_code { FFaker::AddressAU.postcode }") }
      end

      context "attribute name contains postcode" do
        let(:name) { "postcode" }
        it { should eq("postcode { FFaker::AddressAU.postcode }") }
      end

      context "attribute name contains suburb" do
        let(:name) { "suburb" }
        it { should eq("suburb { FFaker::AddressAU.suburb }") }
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