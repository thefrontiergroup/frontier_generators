require 'spec_helper'

RSpec.describe Frontier::FactoryGirlSupport::Declaration do

  describe '#to_s' do
    subject { Frontier::FactoryGirlSupport::Declaration.new("build", model_or_association).to_s }

    context "with a Frontier::ModelConfiguration" do
      let(:model_or_association) { build_model_configuration }
      it { should eq("FactoryGirl.build(:test_model)") }
    end

    context "with a Frontier::Association" do
      let(:model_or_association) { Frontier::Association.new(build_model_configuration, name, options) }
      let(:name) { "association_name" }
      let(:options) { {class_name: class_name} }

      context "without class name" do
        let(:class_name) { nil }
        it { should eq("FactoryGirl.build(:association_name)") }
      end

      context "with class name" do
        let(:class_name) { "new_class_name" }
        it { should eq("FactoryGirl.build(:new_class_name)") }
      end

    end
  end

end
