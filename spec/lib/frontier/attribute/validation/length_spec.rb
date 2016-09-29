require 'spec_helper'

describe Frontier::Attribute::Validation::Length do

  let(:validation) do
    Frontier::Attribute::Validation::Length.new(attribute, key, args)
  end
  let(:attribute) { Frontier::Attribute.new(build_model, name, {}) }
  let(:name)      { "field_name" }
  let(:key)       { "length" }

  describe "#as_implementation" do
    subject { validation.as_implementation }
    let(:args) do
      {
        minimum: 0,
        maximum: 666,
        in: 0..100,
        within: 0..100,
        is: 100,
      }
    end

    it { should eq("length: {minimum: 0, maximum: 666, in: 0..100, within: 0..100, is: 100}") }
  end

  describe "#as_spec" do
    subject { validation.as_spec }

    context "when args is nil" do
      let(:args) { nil }
      it "raises an exception" do
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context "when args is a hash" do

      context "empty hash" do
        let(:args) { {} }
        it "raises an exception" do
          expect { subject }.to raise_error(ArgumentError)
        end
      end

      context "minimum" do
        let(:args) { {minimum: 0} }
        it { should eq("it { should validate_length_of(:field_name).is_at_least(0) }") }
      end

      context "maximum" do
        let(:args) { {maximum: 666} }
        it { should eq("it { should validate_length_of(:field_name).is_at_most(666) }") }
      end

      context "in" do
        let(:args) { {in: 0..666} }
        it { should eq("it { should validate_length_of(:field_name).is_at_least(0).is_at_most(666) }") }
      end

      context "within" do
        let(:args) { {within: 0..666} }
        it { should eq("it { should validate_length_of(:field_name).is_at_least(0).is_at_most(666) }") }
      end

      context "is" do
        let(:args) { {is: 666} }
        it { should eq("it { should validate_length_of(:field_name).is_equal_to(666) }") }
      end

      context "combining additional spec options" do
        let(:args) { {minimum: 0, maximum: 666} }
        it { should eq("it { should validate_length_of(:field_name).is_at_least(0).is_at_most(666) }") }
      end

      context "other type" do
        let(:args) { {less_than_or_equal_two: 666} }
        specify { expect { subject }.to raise_error(ArgumentError) }
      end
    end
  end

end
