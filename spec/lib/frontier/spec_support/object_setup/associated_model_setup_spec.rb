require 'spec_helper'

RSpec.describe Frontier::SpecSupport::ObjectSetup::AssociatedModelSetup do

  describe "#to_s" do
    subject { Frontier::SpecSupport::ObjectSetup::AssociatedModelSetup.new(model_configuration).to_s }
    let(:model_configuration) do
      Frontier::ModelConfiguration.new({
        model_name: {
          attributes: {
            address: {type: "belongs_to", form_type: "select"},
            other_address: {
              type: "belongs_to",
              form_type: "inline",
              attributes: {
                line_1: {type: "string"},
                state: {type: "belongs_to", form_type: "select"}
              }
            },
            name: {type: "string"},
          }
        }
      })
    end

    let(:expected) do
      raw = <<STRING
let(:address) { FactoryGirl.create(:address) }
let(:state) { FactoryGirl.create(:state) }
STRING
      raw.rstrip
    end

    it { should eq(expected) }
  end

end
