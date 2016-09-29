require 'spec_helper'

RSpec.describe Frontier::ControllerActionSupport::NestedAssociationBuilder do

  describe "#to_s" do
    subject { Frontier::ControllerActionSupport::NestedAssociationBuilder.new(model, "@test_model").to_s }

    context "a model without any associations" do
      let(:model) { build_model }

      it { should eq("") }
    end

    context "a model with shallow nested associations" do
      let(:model) do
        Frontier::Model.new({
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
              },
              name: {type: "string"},
            }
          }
        })
      end

      let(:expected) do
        raw = <<-STRING
if @test_model.other_address.blank?
  @test_model.build_other_address
end
STRING
        raw.rstrip
      end

      it { should eq(expected) }
    end

    context "a model with deeply nested associations" do
      let(:model) do
        Frontier::Model.new({
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
              },
              name: {type: "string"},
            }
          }
        })
      end

      let(:expected) do
        raw = <<-STRING
if @test_model.other_address.blank?
  @test_model.build_other_address
  @test_model.other_address.build_state
end
STRING
        raw.rstrip
      end

      it { should eq(expected) }
    end

    context "a model with a nested association that has multiple nested associations" do
      let(:model) do
        Frontier::Model.new({
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
                  },
                  contact_person: {
                    type: "belongs_to",
                    form_type: "inline",
                    attributes: {
                      name: {type: "string"}
                    }
                  }
                }
              },
              name: {type: "string"},
            }
          }
        })
      end

      let(:expected) do
        raw = <<-STRING
if @test_model.other_address.blank?
  @test_model.build_other_address
  @test_model.other_address.build_state
  @test_model.other_address.build_contact_person
end
STRING
        raw.rstrip
      end

      it { should eq(expected) }
    end
  end

end
