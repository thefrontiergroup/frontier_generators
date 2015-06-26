require 'spec_helper'

describe MigrationStringBuilder do

  let(:builder) { MigrationStringBuilder.new(configuration) }
  let(:configuration)   { ModelConfiguration.new(test_model_path) }
  let(:test_model_path) { File.join("spec", "support", "test_model.yaml") }

  describe "#to_s" do
    subject(:output) { builder.to_s }

    it { should eq "CreateTestModel name:string:index created_at:datetime updated_at:datetime" }

    describe "option: soft_delete" do
      before { allow(configuration).to receive(:soft_delete) { soft_delete } }

      context "when soft_delete is false" do
        let(:soft_delete) { false }
        it { should_not include "deleted_at:datetime:index" }
      end

      context "when soft_delete is true" do
        let(:soft_delete) { true }
        it { should include "deleted_at:datetime:index" }
      end
    end
  end
end