require 'spec_helper'

describe Frontier::Attribute::Validation::Uniqueness do

  let(:validation) do
    Frontier::Attribute::Validation::Uniqueness.new(attribute, key, args)
  end
  let(:attribute) { Frontier::Attribute.new(build_model_configuration, name, {}) }
  let(:name)      { "field_name" }
  let(:key)       { "uniqueness" }

  describe "#as_implementation" do
    subject { validation.as_implementation }

    context "with args" do
      let(:args) { {"scope" => "user_id"} }
      it { should eq("uniqueness: {scope: :user_id}") }
    end

    context "with boolean" do
      let(:args) { true }
      it { should eq("uniqueness: true") }
    end
  end

  describe "#as_spec" do
    subject { validation.as_spec }

    context "when args is nil" do
      let(:args) { nil }
      it "raises an exception" do
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context "when args is a boolean" do

      context "false" do
        let(:args) { false }
        it "raises an exception" do
          expect { subject }.to raise_error(ArgumentError)
        end
      end

      context "true" do
        let(:args) { true }

        let(:expected) do
          raw = <<STRING
describe "validating uniqueness" do
  subject { FactoryGirl.create(:test_model) }
  it { should validate_uniqueness_of(:field_name) }
end
STRING
          raw.rstrip
        end

        it { should eq(expected) }
      end
    end

    context "when args is a hash" do

      context "empty hash" do
        let(:args) { {} }
        it "raises an exception" do
          expect { subject }.to raise_error(ArgumentError)
        end
      end

      context "scope" do
        let(:args) { {"scope" => "jordan_id"} }

        let(:expected) do
          raw = <<STRING
describe "validating uniqueness" do
  subject { FactoryGirl.create(:test_model) }
  it { should validate_uniqueness_of(:field_name).scoped_to(:jordan_id) }
end
STRING
          raw.rstrip
        end

        it { should eq(expected) }
      end

      context "other type" do
        let(:args) { {somethang_else: 666} }
        specify { expect { subject }.to raise_error(ArgumentError) }
      end
    end
  end

end
