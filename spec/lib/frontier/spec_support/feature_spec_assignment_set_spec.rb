require 'spec_helper'

RSpec.describe Frontier::SpecSupport::FeatureSpecAssignmentSet do

  describe '#to_s' do
    subject { Frontier::SpecSupport::FeatureSpecAssignmentSet.new(model_configuration).to_s }
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
# ModelName assignments
fill_in("Name", with: model_name_attributes[:name])
select(address, from: "Address")
# Address assignments
fill_in("Line 1", with: other_address_attributes[:line_1])
select(state, from: "State")
STRING
      raw.rstrip
    end

    it { should eq(expected) }
  end

end
