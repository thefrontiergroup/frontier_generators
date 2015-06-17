require 'spec_helper'

describe ModelConfiguration::Association do

  let(:association) { ModelConfiguration::Association.new(build_model_configuration, name, options) }
  let(:name) { "association_name" }
  let(:options) { {} }

  describe "#as_factory_name" do
    subject { association.as_factory_name }

    context "with class_name declared" do
      let(:expected_output) { ":dong" }
      let(:options) { {class_name: "Dong"} }

      it { should eq(expected_output) }
    end

    context "without class_name declared" do
      let(:expected_output) { ":model" }

      context "when field_name includes _id already" do
        let(:name) { "model_id" }
        it { should eq(expected_output) }
      end

      context "when field_name doesn't include _id" do
        let(:name) { "model" }
        it { should eq(expected_output) }
      end
    end
  end

  describe "#as_field_name" do
    subject { association.as_field_name }

    context "when field_name includes _id already" do
      let(:name) { "model_id" }
      it { should eq(":model_id") }
    end

    context "when field_name doesn't include _id" do
      let(:name) { "model" }
      it { should eq(":model_id") }
    end
  end

  describe "#as_input" do
    subject { association.as_input(input_options) }
    let(:input_options) { {} }

    describe "providing additional options" do
      let(:expected_output) { "f.input :model_id, collection: Model.all, my_option: :jordan_rules" }
      let(:name) { "model_id" }
      let(:input_options) { {my_option: ":jordan_rules"} }

      it { should eq(expected_output) }
    end

    describe "setting name of input" do
      context "with class_name declared" do
        let(:expected_output) { "f.input :association_name_id, collection: Dong.all" }
        let(:options) { {class_name: "Dong"} }

        it { should eq(expected_output) }
      end

      context "without class_name declared" do
        let(:expected_output) { "f.input :model_id, collection: Model.all" }

        context "when field_name includes _id already" do
          let(:name) { "model_id" }
          it { should eq(expected_output) }
        end

        context "when field_name doesn't include _id" do
          let(:name) { "model" }
          it { should eq(expected_output) }
        end
      end
    end
  end

  describe "#is_association?" do
    subject { association.is_association? }
    it { should eq(true) }
  end

end