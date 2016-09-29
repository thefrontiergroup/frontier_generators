require 'spec_helper'

describe Frontier::Controller::SpecPath do

  describe '#to_s' do
    subject { class_name.to_s }
    let(:class_name) { Frontier::Controller::SpecPath.new(model) }
    let(:model) do
      Frontier::Model.new({
        "user_document" => {
          controller_prefixes: controller_prefixes
        }
      })
    end

    context "when there are no namespaces or nested models" do
      let(:controller_prefixes) { nil }
      it { should eq("spec/controllers/user_documents_controller_spec.rb") }
    end

    context "when there are namespaces" do
      let(:controller_prefixes) { ["admin"] }
      it { should eq("spec/controllers/admin/user_documents_controller_spec.rb") }
    end

    context "when there are nested models" do
      let(:controller_prefixes) { ["@client"] }
      it { should eq("spec/controllers/client/user_documents_controller_spec.rb") }
    end

    context "when there are both namespaces and nested models" do
      let(:controller_prefixes) { ["admin", "@client"] }
      it { should eq("spec/controllers/admin/client/user_documents_controller_spec.rb") }
    end
  end

end
