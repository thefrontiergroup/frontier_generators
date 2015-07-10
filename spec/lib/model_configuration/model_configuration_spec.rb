require 'spec_helper'

describe ModelConfiguration do

  let(:configuration) { build_model_configuration }

  describe "#as_constant" do
    subject { configuration.as_constant }
    it { should eq("TestModel") }
  end

  describe "#as_symbol" do
    subject { configuration.as_symbol }
    it { should eq(":test_model") }
  end

  describe "#as_symbol_collection" do
    subject { configuration.as_symbol_collection }
    it { should eq(":test_models") }
  end

  describe "#as_title" do
    subject { configuration.as_title }
    it { should eq("Test Model") }
  end

  describe "#ivar_collection" do
    subject { configuration.ivar_collection }
    it { should eq("@test_models") }
  end

  describe "#ivar_instance" do
    subject { configuration.ivar_instance }
    it { should eq("@test_model") }
  end

  describe "hiding/showing UI elements" do

  end

end