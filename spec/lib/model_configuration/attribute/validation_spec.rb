require 'spec_helper'

describe ModelConfiguration::Attribute::Validation do
  let(:attribute) { ModelConfiguration::Attribute.new(build_model_configuration, name, options) }

  describe "#as_implementation" do
    subject { ModelConfiguration::Attribute::Validation.new(attribute, key, args).as_implementation }
    let(:key)       { "presence" }
    let(:name)      { "field_name" }
    let(:options)   { {} }

    context "inclusion" do
      let(:key)  { "inclusion" }
      let(:args) { [1, 2] }
      it { should eq("inclusion: TestModel::FIELD_NAME_VALUES") }
    end

    describe "including arguments" do
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
  end

  describe "#as_spec" do
    subject { ModelConfiguration::Attribute::Validation.new(attribute, key, args).as_spec }
    let(:name)      { "field_name" }
    let(:options)   { {} }
    let(:args)      { {} }

    context "validation is 'inclusion'" do
      let(:key)  { "inclusion" }
      let(:args) { [1, 2, 3] }
      it { should eq("it { should validate_inclusion_of(:field_name).in_array(TestModel::FIELD_NAME_VALUES) }") }
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