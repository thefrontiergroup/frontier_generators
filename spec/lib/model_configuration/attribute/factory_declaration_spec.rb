require 'spec_helper'

describe ModelConfiguration::Attribute::FactoryDeclaration do

  describe "#to_s" do
    subject { ModelConfiguration::Attribute::FactoryDeclaration.new(attribute).to_s }
    let(:attribute) { ModelConfiguration::Attribute.new(build_model_configuration, name, options) }
    let(:name)      { "field_name" }
    let(:options)   { {type: type} }

    context "attribute has an inclusion validation" do
      let(:options) { {type: "string", validates: {inclusion: [1, 2]}} }

      it { should eq("field_name { TestModel::FIELD_NAME_VALUES.sample }")}
    end

    context "type is 'boolean'" do
      let(:type) { "boolean" }
      it { should eq("field_name { [true, false].sample }") }
    end

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
      let(:type) { "enum" }

      it { should eq("field_name { TestModel.field_names.keys.sample }") }
    end

    context "type is 'integer'" do
      let(:type) { "integer" }

      context "when attribute has a validation on numericality" do
        let(:options) do
          {
            type: type,
            validates: {
              numericality: numericality_rules
            }
          }
        end

        context "when validation is for greater_than/less_than" do
          let(:numericality_rules) do
            {
              greater_than: 44,
              less_than: 99
            }
          end
          it { should eq("field_name { rand(44..99) }") }
        end

        context "when validation is for greater_than_or_equal_to/less_than_or_equal_to" do
          let(:numericality_rules) do
            {
              greater_than_or_equal_to: 44,
              less_than_or_equal_to: 99
            }
          end
          it { should eq("field_name { rand(44..99) }") }
        end

        context "when validation doesn't include a greater_than or greater_than_or_equal_to component" do
          let(:numericality_rules) do
            {
              less_than: 99
            }
          end
          it { should eq("field_name { rand(0..99) }") }
        end

        context "when validation doesn't include a less_than or less_than_or_equal_to component" do
          let(:numericality_rules) do
            {
              greater_than: 99
            }
          end
          it { should eq("field_name { rand(99..9999) }") }
        end
      end

      context "when attribute has not validation on numericality" do
        it { should eq("field_name { rand(9999) }") }
      end
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

    context "type is 'text'" do
      let(:type) { "text" }
      it { should eq("field_name { FFaker::Lorem.paragraph(5) }") }
    end

    context "type is something else" do
      let(:type) { "heroin" }
      specify { expect { subject }.to raise_error(ArgumentError) }
    end
  end

end