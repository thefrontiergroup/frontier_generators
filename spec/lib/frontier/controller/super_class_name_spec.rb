require 'spec_helper'

describe Frontier::Controller::SuperClassName do

  describe '#to_s' do
    subject { class_name.to_s }
    let(:class_name) { Frontier::Controller::SuperClassName.new(model_configuration) }
    let(:model_configuration) do
      Frontier::ModelConfiguration.new({
        "user_document" => {
          controller_prefixes: controller_prefixes
        }
      })
    end

    context "when there are no namespaces or nested models" do
      let(:controller_prefixes) { nil }
      it { should eq("ApplicationController") }
    end

    context "when there are namespaces" do
      let(:controller_prefixes) { ["admin"] }
      it { should eq("Admin::BaseController") }
    end

    context "when there are nested models" do
      let(:controller_prefixes) { ["@client"] }
      it { should eq("Client::BaseController") }
    end

    context "when there are both namespaces and nested models" do
      let(:controller_prefixes) { ["admin", "@client"] }
      it { should eq("Admin::Client::BaseController") }
    end
  end

end
