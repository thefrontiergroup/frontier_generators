require 'spec_helper'

describe Frontier::Model do

  let(:model) { build_model }

  describe "#as_collection" do
    subject { model.as_collection }
    it { should eq("test_models") }
  end

  describe "#as_constant" do
    subject { model.as_constant }
    it { should eq("TestModel") }
  end

  describe "#as_ivar_collection" do
    subject { model.as_ivar_collection }
    it { should eq("@test_models") }
  end

  describe "#as_symbol" do
    subject { model.as_symbol }
    it { should eq(":test_model") }
  end

  describe "#as_symbol_collection" do
    subject { model.as_symbol_collection }
    it { should eq(":test_models") }
  end

  describe "#as_name" do
    subject { model.as_name }
    it { should eq("test model") }
  end

  describe "#as_title" do
    subject { model.as_title }
    it { should eq("Test Model") }
  end

  describe "#as_ivar_instance" do
    subject { model.as_ivar_instance }
    it { should eq("@test_model") }
  end

  describe "#primary_attribute" do
    subject(:primary_attribute) { model.primary_attribute }

    let(:model) { Frontier::Model.new(model_options) }
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

  describe '#initialize' do

    describe "assigning @authorization" do
      subject { model.authorization }
      let(:model) { Frontier::Model.new(model_options) }
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

    describe "assigning @controller_prefixes" do
      subject { model.controller_prefixes.map(&:name) }
      let(:model) { Frontier::Model.new(model_options) }
      let(:model_options) { {test_model: {controller_prefixes: controller_prefixes}} }

      context "when an array is passed through" do
        let(:controller_prefixes) { ["admin"] }
        it { should eq(["admin"]) }
      end

      context "when some other non-nil type is passed through" do
        let(:controller_prefixes) { "admin" }
        specify { expect { subject }.to raise_exception(ArgumentError) }
      end

      context "when nil is passed through" do
        let(:controller_prefixes) { nil }
        it { should eq([]) }
      end

    end

    describe "assigning @skip_factory" do
      subject { model.skip_factory? }

      let(:model) { Frontier::Model.new(model_options) }
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
      subject { model.skip_model? }

      let(:model) { Frontier::Model.new(model_options) }
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
      subject { model.skip_seeds? }

      let(:model) { Frontier::Model.new(model_options) }
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
      subject { model.skip_policies? }

      let(:model) { Frontier::Model.new(model_options) }
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
      let(:model) { Frontier::Model.new(model_options) }
      let(:model_options) { {test_model: {skip_ui: skip_ui}} }

      [
        [:show_index?, "index"],
        [:show_delete?, "delete"],
        [:show_create?, "create"],
        [:show_update?, "update"],
      ].each do |method_name, action|

        describe "##{method_name}" do
          subject { model.send(method_name) }

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
  end

  describe "#using_pundit?" do
    subject { model.using_pundit? }
    let(:model) { Frontier::Model.new(model_options) }
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

  describe "#view_paths" do
    subject { model.view_paths }
    let(:model) { Frontier::Model.new(model_options) }
    let(:model_options) { {test_model: {view_path_attributes: view_path_attributes}} }

    context "when nil" do
      let(:view_path_attributes) { nil }
      it { should be_kind_of(Frontier::Model::ViewPaths) }
    end

    context "when set" do
      let(:view_path_attributes) { {} }
      it { should be_kind_of(Frontier::Model::ViewPaths) }
    end
  end

end
