require 'spec_helper'

describe Frontier::Association::ModelImplementation do

  describe "#to_s" do
    subject { Frontier::Association::ModelImplementation.new(attribute).to_s }
    let(:attribute) { Frontier::Association.new(build_model_configuration, name, options) }
    let(:name)      { "association_name" }
    let(:options)   { {type: type}.merge(additional_options) }
    let(:additional_options) { {} }

    context "belongs_to" do
      let(:type) { "belongs_to" }

      context "class_name is set" do
        let(:additional_options) { {class_name: "ClassName"} }
        it { should eq("belongs_to :association_name, class_name: ClassName") }
      end

      context "class_name is not set" do
        let(:class_name) { nil }
        it { should eq("belongs_to :association_name") }
      end

      context "using inline form" do
        let(:additional_options) { {form_type: "inline"} }
        it { should eq("belongs_to :association_name\naccepts_nested_attributes_for :association_name") }
      end
    end
  end

end
