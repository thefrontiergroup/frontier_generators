class Frontier::SpecSupport::ObjectSetup

  include Frontier::ModelConfigurationProperty

  # Render a set of params that can be used in the controller specs. We need to use FactoryGirl
  # as much as possible to reduce duplication in the code.
  #
  # Params for a basic model might look like:
  #
  #   let(:model_attributes) { FactoryGirl.attributes_for(:model) }
  #   let(:attributes) do
  #     {
  #       name: model_attributes[:name]
  #     }
  #   end
  #
  # Params for a more complicated model with nested associations might look like:
  #
  #   let(:model_attributes) { FactoryGirl.attributes_for(:model) }
  #   let(:address_attributes) { FactoryGirl.attributes_for(:address) }
  #   let!(:state) { FactoryGirl.create(:state) }
  #   let(:attributes) do
  #     {
  #       name: model_attributes[:name],
  #       address_attributes: {
  #         line_1: address_attributes[:line_1],
  #         line_2: address_attributes[:line_2],
  #         city: address_attributes[:city],
  #         state: state
  #       }
  #     }
  #   end
  def to_s
    [
      Frontier::SpecSupport::ObjectSetup::AttributesSetup.new(model_configuration).to_s,
      Frontier::SpecSupport::ObjectSetup::AssociatedModelSetup.new(model_configuration).to_s,
      Frontier::SpecSupport::ObjectSetup::Attributes.new(model_configuration).to_s
    ].select(&:present?).join("\n")
  end

end

require_relative "./object_setup/associated_model_setup"
require_relative "./object_setup/attributes"
require_relative "./object_setup/attributes_hash"
require_relative "./object_setup/attributes_setup"
