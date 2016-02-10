require 'spec_helper'

RSpec.describe Frontier::SpecSupport::ControllerParams do

  describe '#to_s' do
    subject { Frontier::SpecSupport::ControllerParams.new(model_configuration).to_s }
    let(:model_configuration) do
      Frontier::ModelConfiguration.new({
        model_name: {
          attributes: {
            address: {type: "belongs_to", form_type: "select"},
            other_address: {
              class_name: "Address",
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
let(:attributes) { FactoryGirl.attributes_for(:model_name) }
let(:other_address_attributes) { FactoryGirl.attributes_for(:address) }
let(:address) { FactoryGirl.create(:address) }
let(:state) { FactoryGirl.create(:state) }
let(:model_name_params) do
  {
    address_id: address.id,
    other_address_attributes: {
      line_1: other_address_attributes[:line_1],
      state_id: state.id,
    },
    name: attributes[:name],
  }
end
STRING
      raw.rstrip
    end

    it { should eq(expected) }
  end

end
