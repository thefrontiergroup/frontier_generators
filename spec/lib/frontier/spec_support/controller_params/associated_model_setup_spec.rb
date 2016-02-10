require 'spec_helper'

RSpec.describe Frontier::SpecSupport::ControllerParams::AssociatedModelSetup do

  describe "#to_s" do
    subject { Frontier::SpecSupport::ControllerParams::AssociatedModelSetup.new(model_configuration).to_s }
    let(:model_configuration) do
      Frontier::ModelConfiguration.new({
        model_name: {
          attributes: {
            address: {type: "belongs_to", form_type: form_type},
            name: {type: "string"},
          }
        }
      })
    end

    context "without nested attributes" do
      let(:form_type) { "select" }
      let(:expected) do
        "let(:address) { FactoryGirl.create(:address) }"
      end

      it { should eq(expected) }
    end

    context "with nested attributes" do
      let(:form_type) { "inline" }

      it { should be_empty }
    end

  end

end
