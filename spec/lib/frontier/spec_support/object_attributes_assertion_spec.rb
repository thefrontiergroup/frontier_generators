require 'spec_helper'

RSpec.describe Frontier::SpecSupport::ObjectAttributesAssertion do

  describe '#to_s' do
    subject { Frontier::SpecSupport::ObjectAttributesAssertion.new(model_configuration).to_s }

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
            omitted_attribute: {type: "string", show_on_form: false}
          }
        }
      })
    end

    let(:expected) do
      raw = <<STRING
expect(model_name.name).to eq(model_name_attributes[:name])
expect(model_name.address).to eq(address)
expect(model_name.other_address.line_1).to eq(other_address_attributes[:line_1])
expect(model_name.other_address.state).to eq(state)
STRING
      raw.rstrip
    end

    it { should eq(expected) }
  end

end
