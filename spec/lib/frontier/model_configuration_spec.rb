require 'spec_helper'

describe Frontier::ModelConfiguration do

  let(:model_configuration) { build_model_configuration }

  describe "#as_constant" do
    subject { model_configuration.as_constant }
    it { should eq("TestModel") }
  end

  describe "#as_ivar_collection" do
    subject { model_configuration.as_ivar_collection }
    it { should eq("@test_models") }
  end

  describe "#as_symbol" do
    subject { model_configuration.as_symbol }
    it { should eq(":test_model") }
  end

  describe "#as_symbol_collection" do
    subject { model_configuration.as_symbol_collection }
    it { should eq(":test_models") }
  end

  describe "#as_name" do
    subject { model_configuration.as_name }
    it { should eq("test model") }
  end

  describe "#as_title" do
    subject { model_configuration.as_title }
    it { should eq("Test Model") }
  end

  describe "#as_ivar_instance" do
    subject { model_configuration.as_ivar_instance }
    it { should eq("@test_model") }
  end

  describe "#primary_attribute" do
    subject(:primary_attribute) { model_configuration.primary_attribute }

    let(:model_configuration) { Frontier::ModelConfiguration.new(model_options) }
    let(:model_options) do
      {
        test_model: {
          attributes: attributes
        }
      }
    end

    context "when there is a primary attribute" do
      let(:attributes) do
          {
            primary_attribute: {primary: true},
            other_attribute: {}
          }
      end
      it "returns the primary attribute" do
        expect(primary_attribute.name).to eq("primary_attribute")
      end
    end

    context "when there is no primary attribute" do
      let(:attributes) do
        {
          primary_attribute: {},
          other_attribute: {}
        }
      end

      it "returns the first attribute" do
        expect(primary_attribute.name).to eq("primary_attribute")
      end
    end
  end

  describe "assigning @authorization" do
    subject { model_configuration.authorization }
    let(:model_configuration) { Frontier::ModelConfiguration.new(model_options) }
    let(:model_options) { {test_model: {authorization: authorization}} }

    context "when authorization is provided as a config option" do
      let(:authorization) { "cancancan" }
      it { should eq("cancancan") }
    end

    context "when no authorization is provided as a config option" do
      let(:authorization) { nil }
      it { should eq("pundit") }
    end
  end

  describe "assigning @skip_factory" do
    subject { model_configuration.skip_factory? }

    let(:model_configuration) { Frontier::ModelConfiguration.new(model_options) }
    let(:model_options) { {test_model: {skip_factory: skip_factory}} }

    context "when skip_factory is true" do
      let(:skip_factory) { true }
      it { should eq(true) }
    end

    context "when skip_factory is false" do
      let(:skip_factory) { false }
      it { should eq(false) }
    end

    context "when skip_factory is nil" do
      let(:skip_factory) { nil }
      it { should eq(false) }
    end
  end

  describe "assigning @skip_model" do
    subject { model_configuration.skip_model? }

    let(:model_configuration) { Frontier::ModelConfiguration.new(model_options) }
    let(:model_options) { {test_model: {skip_model: skip_model}} }

    context "when skip_model is true" do
      let(:skip_model) { true }
      it { should eq(true) }
    end

    context "when skip_model is false" do
      let(:skip_model) { false }
      it { should eq(false) }
    end

    context "when skip_model is nil" do
      let(:skip_model) { nil }
      it { should eq(false) }
    end
  end

  describe "assigning @skip_seeds" do
    subject { model_configuration.skip_seeds? }

    let(:model_configuration) { Frontier::ModelConfiguration.new(model_options) }
    let(:model_options) { {test_model: {skip_seeds: skip_seeds}} }

    context "when skip_seeds is true" do
      let(:skip_seeds) { true }
      it { should eq(true) }
    end

    context "when skip_seeds is false" do
      let(:skip_seeds) { false }
      it { should eq(false) }
    end

    context "when skip_seeds is nil" do
      let(:skip_seeds) { nil }
      it { should eq(false) }
    end
  end

  describe "assigning @skip_policies" do
    subject { model_configuration.skip_policies? }

    let(:model_configuration) { Frontier::ModelConfiguration.new(model_options) }
    let(:model_options) { {test_model: {skip_policies: skip_policies}} }

    context "when skip_policies is true" do
      let(:skip_policies) { true }
      it { should eq(true) }
    end

    context "when skip_policies is false" do
      let(:skip_policies) { false }
      it { should eq(false) }
    end

    context "when skip_policies is nil" do
      let(:skip_policies) { nil }
      it { should eq(false) }
    end
  end

  describe "hiding/showing UI elements" do
    let(:model_configuration) { Frontier::ModelConfiguration.new(model_options) }
    let(:model_options) { {test_model: {skip_ui: skip_ui}} }

    [
      [:show_index?, "index"],
      [:show_delete?, "delete"],
      [:show_create?, "create"],
      [:show_update?, "update"],
    ].each do |method_name, action|

      describe "##{method_name}" do
        subject { model_configuration.send(method_name) }

        context "when skip_ui is true" do
          let(:skip_ui) { true }
          it { should eq(false) }
        end

        context "when skip_ui is false" do
          let(:skip_ui) { false }
          it { should eq(true) }
        end

        context "when skip_ui is nil (undefined)" do
          let(:skip_ui) { nil }
          it { should eq(true) }
        end

        context "when skip_ui is an array that includes index" do
          let(:skip_ui) { [action] }
          it { should eq(false) }
        end

        context "when skip_ui is an array that doesn't include index" do
          let(:skip_ui) { ["to the windows, to the walls"] }
          it { should eq(true) }
        end
      end
    end

  end

  describe "#using_pundit?" do
    subject { model_configuration.using_pundit? }
    let(:model_configuration) { Frontier::ModelConfiguration.new(model_options) }
    let(:model_options) { {test_model: {authorization: authorization}} }

    context "when authorization is pundit" do
      let(:authorization) { "pundit" }
      it { should eq(true) }
    end

    context "when authorization is not pundit" do
      let(:authorization) { "cancancan" }
      it { should eq(false) }
    end

    context "when no authorization is provided as a config option" do
      let(:authorization) { nil }
      it { should eq(true) }
    end
  end

end
