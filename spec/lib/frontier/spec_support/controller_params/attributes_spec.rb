require 'spec_helper'

RSpec.describe Frontier::SpecSupport::ControllerParams::Attributes do

  describe '#to_s' do
    subject { Frontier::SpecSupport::ControllerParams::Attributes.new(model_configuration).to_s }
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
let(:model_name_params) do
  {
    address_id: address.id,
    other_address_attributes: {
      line_1: other_address_attributes[:line_1],
      state_id: state.id
    },
    name: attributes[:name]
  }
end
STRING
      raw.rstrip
    end

    it { should eq(expected) }
  end

end
