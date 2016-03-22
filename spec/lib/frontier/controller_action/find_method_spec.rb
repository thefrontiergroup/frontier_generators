require 'spec_helper'

RSpec.describe Frontier::ControllerAction::FindMethod do

  describe "#to_s" do
    subject { Frontier::ControllerAction::FindMethod.new(model_configuration).to_s }
    let(:model_configuration) do
      Frontier::ModelConfiguration.new({
        "test_model" => {controller_prefixes: controller_prefixes}
      })
    end

    describe "model with no namespaces or nested models" do
      let(:controller_prefixes) { nil }

      let(:expected) do
        raw = <<-STRING
def find_test_model
  TestModel.find(params[:id])
end
STRING
        raw.rstrip
      end

      it { should eq(expected) }
    end

    describe "model with a namespace" do
      let(:controller_prefixes) { ["admin"] }

      let(:expected) do
        raw = <<-STRING
def find_test_model
  TestModel.find(params[:id])
end
STRING
        raw.rstrip
      end

      it { should eq(expected) }
    end

    describe "model with a nested model" do
      let(:controller_prefixes) { ["@client"] }

      let(:expected) do
        raw = <<-STRING
def find_test_model
  @client.test_models.find(params[:id])
end
STRING
        raw.rstrip
      end

      it { should eq(expected) }
    end

    describe "model with multiple nested model" do
      let(:controller_prefixes) { ["@client", "@doge"] }

      let(:expected) do
        raw = <<-STRING
def find_test_model
  @doge.test_models.find(params[:id])
end
STRING
        raw.rstrip
      end

      it { should eq(expected) }
    end
  end

end
