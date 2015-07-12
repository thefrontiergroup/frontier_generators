require 'spec_helper'

describe Frontier::Input::Association do

  let(:input_implementation) { Frontier::Input::Association.new(association) }
  let(:association) { ModelConfiguration::Association.new(build_model_configuration, name, options) }
  let(:name) { "association_name_id" }
  let(:options) { {} }

  describe "#to_s" do
    subject { input_implementation.to_s(input_options) }
    let(:input_options) { {} }

    describe "providing additional options" do
      let(:expected_output) { "f.association :association_name_id, collection: AssociationName.all, my_option: :jordan_rules" }
      let(:name) { "association_name_id" }
      let(:input_options) { {my_option: ":jordan_rules"} }

      it { should eq(expected_output) }
    end

    describe "setting name of input" do
      context "with class_name declared" do
        let(:expected_output) { "f.association :association_name_id, collection: Dong.all" }
        let(:options) { {class_name: "Dong"} }

        it { should eq(expected_output) }
      end

      context "without class_name declared" do
        let(:expected_output) { "f.association :association_name_id, collection: AssociationName.all" }

        context "when field_name includes _id already" do
          let(:name) { "association_name_id" }
          it { should eq(expected_output) }
        end

        context "when field_name doesn't include _id" do
          let(:name) { "association_name" }
          it { should eq(expected_output) }
        end
      end
    end
  end

end