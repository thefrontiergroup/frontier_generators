require 'spec_helper'

describe Frontier::Association::FactoryDeclaration do

  describe "#to_s" do
    subject { Frontier::Association::FactoryDeclaration.new(attribute).to_s }
    let(:attribute) { Frontier::Association.new(build_model_configuration, name, options) }
    let(:name)      { "association_name" }
    let(:options)   { {class_name: class_name} }

    context "class_name is set" do
      let(:class_name) { "ClassName" }
      it { should eq("association :association_name, factory: :class_name") }
    end

    context "class_name is not set" do
      let(:class_name) { nil }
      it { should eq("association :association_name") }
    end
  end

end
