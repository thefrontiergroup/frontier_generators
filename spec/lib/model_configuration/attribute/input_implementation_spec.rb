require 'spec_helper'

describe ModelConfiguration::Attribute::InputImplementation do

  let(:input_implementation) { ModelConfiguration::Attribute::InputImplementation.new(attribute) }
  let(:attribute) { ModelConfiguration::Attribute.new(build_model_configuration, name, options) }
  let(:name) { "attribute_name" }
  let(:options) { {} }

  describe "#to_s" do
    subject { input_implementation.to_s(input_options) }
    let(:input_options) { {} }

    describe "providing additional options" do
      let(:input_options) { {my_option: ":jordan_rules"} }

      it { should eq("f.input :attribute_name, my_option: :jordan_rules") }
    end

    describe "attribute must be included in a given collection" do
      let(:options) { {validates: {inclusion: [1,2,3]} } }

      it { should eq("f.input :attribute_name, collection: TestModel::ATTRIBUTE_NAME_VALUES") }
    end
  end

end