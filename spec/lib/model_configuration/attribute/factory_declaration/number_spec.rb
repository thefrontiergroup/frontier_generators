require 'spec_helper'

describe ModelConfiguration::Attribute::FactoryDeclaration::Number do

  describe "#to_s" do
    subject { ModelConfiguration::Attribute::FactoryDeclaration::Number.new(attribute).to_s }
    let(:attribute) { ModelConfiguration::Attribute.new(build_model_configuration, name, options) }
    let(:name)      { "field_name" }
    let(:options)   { {type: "integer"} }

    context "when attribute has a validation on numericality" do
      let(:options) do
        {
          type: "integer",
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
        it { should eq("rand(44..99)") }
      end

      context "when validation is for greater_than_or_equal_to/less_than_or_equal_to" do
        let(:numericality_rules) do
          {
            greater_than_or_equal_to: 44,
            less_than_or_equal_to: 99
          }
        end
        it { should eq("rand(44..99)") }
      end

      context "when validation doesn't include a greater_than or greater_than_or_equal_to component" do
        let(:numericality_rules) do
          {
            less_than: 99
          }
        end
        it { should eq("rand(0..99)") }
      end

      context "when validation doesn't include a less_than or less_than_or_equal_to component" do
        let(:numericality_rules) do
          {
            greater_than: 99
          }
        end
        it { should eq("rand(99..9999)") }
      end
    end

    context "when attribute has not validation on numericality" do
      it { should eq("rand(9999)") }
    end
  end

end