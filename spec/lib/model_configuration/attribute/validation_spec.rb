require 'spec_helper'

describe ModelConfiguration::Attribute::Validation do

  describe "#as_implementation" do
    subject { ModelConfiguration::Attribute::Validation.new(attribute, key, args).as_implementation }
    let(:attribute) { ModelConfiguration::Attribute.new(name, options) }
    let(:key)       { "presence" }
    let(:name)      { "field_name" }
    let(:options)   { {} }

    context "when args are a hash" do
      context "with a single arg" do
        let(:args) { {greater_than: 1} }
        it { should eq("presence: {greater_than: 1}") }
      end

      context "with many args" do
        let(:args) { {greater_than: 1, less_than: 100} }
        it { should eq("presence: {greater_than: 1, less_than: 100}") }
      end
    end

    # EG:
    # attribute_name
    #   validates:
    #     presence: true
    context "when args are not a hash" do
      let(:args) { true }
      it { should eq("presence: true") }
    end
  end

  describe "#as_spec" do
    subject { ModelConfiguration::Attribute::Validation.new(attribute, key, args).as_spec }
    let(:attribute) { ModelConfiguration::Attribute.new(name, options) }
    let(:name)      { "field_name" }
    let(:options)   { {} }
    let(:args)      { {} }

    context "validation is 'numericality'" do
      let(:key) { "numericality" }
      it "passes the responsibility to ModelConfiguration::Attribute::Validation::Numericality" do
        expect_any_instance_of(ModelConfiguration::Attribute::Validation::Numericality).to receive(:as_spec)
        subject
      end
    end

    context "validation is 'presence'" do
      let(:key) { "presence" }
      it { should eq("it { should validate_presence_of(:field_name) }") }
    end

    context "type is 'uniqueness'" do
      let(:key) { "uniqueness" }
      specify { expect { subject }.to raise_error(ArgumentError) }
    end

    context "type is something else" do
      let(:key) { "heroin" }
      specify { expect { subject }.to raise_error(ArgumentError) }
    end
  end

end