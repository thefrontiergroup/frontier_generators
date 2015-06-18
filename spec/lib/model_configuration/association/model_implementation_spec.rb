require 'spec_helper'

describe ModelConfiguration::Association::ModelImplementation do

  describe "#to_s" do
    subject { ModelConfiguration::Association::ModelImplementation.new(attribute).to_s }
    let(:attribute) { ModelConfiguration::Association.new(build_model_configuration, name, options) }
    let(:name)      { "association_name" }
    let(:options)   { {class_name: class_name, type: type} }

    context "belongs_to" do
      let(:type) { "belongs_to" }

      context "class_name is set" do
        let(:class_name) { "ClassName" }
        it { should eq("belongs_to :association_name, class_name: ClassName") }
      end

      context "class_name is not set" do
        let(:class_name) { nil }
        it { should eq("belongs_to :association_name") }
      end
    end
  end

end