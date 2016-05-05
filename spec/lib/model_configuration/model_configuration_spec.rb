require 'spec_helper'

describe ModelConfiguration do

  let(:model_configuration) { build_model_configuration }

  describe "#as_constant" do
    subject { model_configuration.as_constant }
    it { should eq("TestModel") }
  end

  describe "#as_symbol" do
    subject { model_configuration.as_symbol }
    it { should eq(":test_model") }
  end

  describe "#as_symbol_collection" do
    subject { model_configuration.as_symbol_collection }
    it { should eq(":test_models") }
  end

  describe "#as_title" do
    subject { model_configuration.as_title }
    it { should eq("Test Model") }
  end

  describe "#ivar_collection" do
    subject { model_configuration.ivar_collection }
    it { should eq("@test_models") }
  end

  describe "#ivar_instance" do
    subject { model_configuration.ivar_instance }
    it { should eq("@test_model") }
  end

  describe "#primary_attribute" do
    subject(:primary_attribute) { model_configuration.primary_attribute }

    let(:model_configuration) { ModelConfiguration.new(model_options) }
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

  describe "hiding/showing UI elements" do
    let(:model_configuration) { ModelConfiguration.new(model_options) }
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

end