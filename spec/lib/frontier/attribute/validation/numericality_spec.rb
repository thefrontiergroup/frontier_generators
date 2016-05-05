require 'spec_helper'

describe Frontier::Attribute::Validation::Numericality do

  let(:validation) do
    Frontier::Attribute::Validation::Numericality.new(attribute, key, args)
  end
  let(:attribute) { Frontier::Attribute.new(build_model_configuration, name, {}) }
  let(:name)      { "field_name" }
  let(:key)       { "numericality" }

  describe "#as_implementation" do
    subject { validation.as_implementation }
    let(:args) do
      {
        allow_nil: true,
        only_integer: true,
        greater_than: 0,
        greater_than_or_equal_to: 0,
        equal_to: 0,
        less_than: 100,
        less_than_or_equal_to: 100
      }
    end

    it { should eq("numericality: {allow_nil: true, only_integer: true, greater_than: 0, greater_than_or_equal_to: 0, equal_to: 0, less_than: 100, less_than_or_equal_to: 100}") }
  end

  describe "#as_spec" do
    subject { validation.as_spec }

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

      context "allow_nil" do
        let(:args) { {allow_nil: allow_nil} }

        context "is true" do
          let(:allow_nil) { true }
          it { should eq("it { should validate_numericality_of(:field_name).allow_nil }") }
        end

        context "is false" do
          let(:allow_nil) { false }
          it { should eq("it { should validate_numericality_of(:field_name) }") }
        end
      end

      context "only_integer" do
        let(:args) { {only_integer: only_integer} }

        context "is true" do
          let(:only_integer) { true }
          it { should eq("it { should validate_numericality_of(:field_name).only_integer }") }
        end

        context "is false" do
          let(:only_integer) { false }
          it { should eq("it { should validate_numericality_of(:field_name) }") }
        end
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
