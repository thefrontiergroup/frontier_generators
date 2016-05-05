require 'spec_helper'

RSpec.describe Frontier::FactoryGirlSupport::Declaration do

  describe '#to_s' do
    subject { factory_declaration.to_s }
    let(:factory_declaration) { Frontier::FactoryGirlSupport::Declaration.new("build", factory_object) }

    describe "generating factory name" do
      context "with a Frontier::ModelConfiguration" do
        let(:factory_object) { build_model_configuration }
        it { should eq("FactoryGirl.build(:test_model)") }
      end

      context "with a Frontier::Association" do
        let(:factory_object) { Frontier::Association.new(build_model_configuration, name, options) }
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

      context "with a string" do
        let(:factory_object) { "yolotronix" }
        it { should eq("FactoryGirl.build(:yolotronix)") }
      end
    end

    describe "providing additional_options" do
      let(:factory_object) { "yolotronix" }

      context "with no options" do
        subject { factory_declaration.to_s }
        it { should eq("FactoryGirl.build(:yolotronix)") }
      end

      context "with some options" do
        subject { factory_declaration.to_s(options) }
        let(:options) do
          {
            one: '"two"',
            three: :four
          }
        end

        it { should eq("FactoryGirl.build(:yolotronix, one: \"two\", three: :four)") }
      end
    end
  end

end
