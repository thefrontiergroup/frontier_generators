require 'spec_helper'

RSpec.describe Frontier::SpecSupport::ObjectSetup do

  describe '#to_s' do
    subject { Frontier::SpecSupport::ObjectSetup.new(model_configuration).to_s }
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
let(:model_name_attributes) { FactoryGirl.attributes_for(:model_name) }
let(:other_address_attributes) { FactoryGirl.attributes_for(:address) }
let(:address) { FactoryGirl.create(:address) }
let(:state) { FactoryGirl.create(:state) }
let(:attributes) do
  {
    address_id: address.id,
    other_address_attributes: {
      line_1: other_address_attributes[:line_1],
      state_id: state.id
    },
    name: model_name_attributes[:name]
  }
end
STRING
      raw.rstrip
    end

    it { should eq(expected) }
  end

end
