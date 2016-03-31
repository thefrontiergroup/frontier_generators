require 'spec_helper'

describe Frontier::Attribute::FactoryDeclaration do

  describe "#to_s" do
    subject { Frontier::Attribute::FactoryDeclaration.new(attribute).to_s }
    let(:attribute) { Frontier::Attribute.new(build_model_configuration, name, options) }
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
      it { should eq("field_name { 5.days.from_now.to_date }") }
    end

    context "type is 'datetime'" do
      let(:type) { "datetime" }
      it { should eq("field_name { 5.days.from_now }") }
    end

    context "type is 'decimal'" do
      let(:type) { "decimal" }

      before do
        expect_any_instance_of(Frontier::Attribute::FactoryDeclaration::Number).to receive(:to_s).and_return("some_number_value")
      end

      it { should eq("field_name { some_number_value }") }
    end

    context "type is 'enum'" do
      let(:type) { "enum" }

      it { should eq("field_name { TestModel.field_names.keys.sample }") }
    end

    context "type is 'integer'" do
      let(:type) { "integer" }

      before do
        expect_any_instance_of(Frontier::Attribute::FactoryDeclaration::Number).to receive(:to_s).and_return("some_number_value")
      end

      it { should eq("field_name { some_number_value }") }
    end

    context "type is 'string'" do
      let(:type) { "string" }

      before do
        expect_any_instance_of(Frontier::Attribute::FactoryDeclaration::String).to receive(:to_s).and_return("some_string_value")
      end

      it { should eq("field_name { some_string_value }") }
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
