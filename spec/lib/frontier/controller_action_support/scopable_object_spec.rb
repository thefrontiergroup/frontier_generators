require 'spec_helper'

RSpec.describe Frontier::ControllerActionSupport::ScopableObject do

  describe "#to_s" do
    subject { Frontier::ControllerActionSupport::ScopableObject.new(model_configuration).to_s }
    let(:model_configuration) do
      Frontier::ModelConfiguration.new({
        "test_model" => {controller_prefixes: controller_prefixes}
      })
    end

    describe "model with no namespaces or nested models" do
      let(:controller_prefixes) { nil }

      it { should eq("TestModel") }
    end

    describe "model with a namespace" do
      let(:controller_prefixes) { ["admin"] }

      it { should eq("TestModel") }
    end

    describe "model with a nested model" do
      let(:controller_prefixes) { ["@client"] }

      it { should eq("@client.test_models") }
    end

    describe "model with multiple nested model" do
      let(:controller_prefixes) { ["@client", "@doge"] }

      it { should eq("@doge.test_models") }
    end
  end

end
