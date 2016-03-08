require 'spec_helper'

describe Frontier::ControllerActionSupport::StrongParamsAttributes do

  describe "#to_array" do
    subject { strongs_params_hash.to_array }
    let(:strongs_params_hash) do
      Frontier::ControllerActionSupport::StrongParamsAttributes.new(model_configuration)
    end

    context "a simple model" do
      let(:model_configuration) do
        Frontier::ModelConfiguration.new({
          test_model: {
            attributes: {
              charlie: {type: "string"},
              address: {type: "belongs_to", form_type: "select"},
              bravo: {type: "string"},
            }
          }
        })
      end

      it { should eq([:address_id, :bravo, :charlie]) }
    end

    context "a model with a nested association" do
      let(:model_configuration) do
        Frontier::ModelConfiguration.new({
          test_model: {
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
              }
            }
          }
        })
      end

      it { should eq([:address_id, other_address_attributes: [:line_1, :state_id]]) }
    end

    context "a model with a deeply nested association" do
      let(:model_configuration) do
        Frontier::ModelConfiguration.new({
          test_model: {
            attributes: {
              address: {type: "belongs_to", form_type: "select"},
              other_address: {
                class_name: "Address",
                type: "belongs_to",
                form_type: "inline",
                attributes: {
                  line_1: {type: "string"},
                  state: {
                    type: "belongs_to",
                    form_type: "inline",
                    attributes: {
                      name: {type: "string"}
                    }
                  }
                }
              }
            }
          }
        })
      end

      it { should eq([:address_id, other_address_attributes: [:line_1, state_attributes: [:name]]]) }
    end
  end

end
