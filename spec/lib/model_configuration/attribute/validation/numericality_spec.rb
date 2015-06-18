require 'spec_helper'

describe ModelConfiguration::Attribute::Validation::Numericality do

  describe "#as_spec" do
    subject { ModelConfiguration::Attribute::Validation::Numericality.new(attribute, key, args).as_spec }
    let(:attribute) { ModelConfiguration::Attribute.new(build_model_configuration, name, {}) }
    let(:name)      { "field_name" }
    let(:key)       { "numericality" }

    context "when args is nil" do
      let(:args) { nil }
      it { should eq("it { should validate_numericality_of(:field_name) }") }
    end

    # EG:
    #  validates:
    #    numericality: true
    context "when args is boolean" do
      let(:args) { true }
      it { should eq("it { should validate_numericality_of(:field_name) }") }
    end

    context "when args is a hash" do

      context "empty hash" do
        let(:args) { {} }
        it { should eq("it { should validate_numericality_of(:field_name) }") }
      end

      context "greater_than" do
        let(:args) { {greater_than: 666} }
        it { should eq("it { should validate_numericality_of(:field_name).is_greater_than(666) }") }
      end

      context "greater_than_or_equal_to" do
        let(:args) { {greater_than_or_equal_to: 666} }
        it { should eq("it { should validate_numericality_of(:field_name).is_greater_than_or_equal_to(666) }") }
      end

      context "equal_to" do
        let(:args) { {equal_to: 666} }
        it { should eq("it { should validate_numericality_of(:field_name).is_equal_to(666) }") }
      end

      context "less_than" do
        let(:args) { {less_than: 666} }
        it { should eq("it { should validate_numericality_of(:field_name).is_less_than(666) }") }
      end

      context "less_than_or_equal_to" do
        let(:args) { {less_than_or_equal_to: 666} }
        it { should eq("it { should validate_numericality_of(:field_name).is_less_than_or_equal_to(666) }") }
      end

      context "combining additional spec options" do
        let(:args) { {greater_than: 0, less_than: 666} }
        it { should eq("it { should validate_numericality_of(:field_name).is_greater_than(0).is_less_than(666) }") }
      end

      context "other type" do
        let(:args) { {less_than_or_equal_two: 666} }
        specify { expect { subject }.to raise_error(ArgumentError) }
      end
    end
  end

end