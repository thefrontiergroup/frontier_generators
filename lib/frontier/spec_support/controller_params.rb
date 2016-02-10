class Frontier::SpecSupport::ControllerParams

  attr_reader :model_configuration

  def initialize(model_configuration)
    @model_configuration = model_configuration
  end

  # Render a set of params that can be used in the controller specs. We need to use FactoryGirl
  # as much as possible to reduce duplication in the code.
  #
  # Params for a basic model might look like:
  #
  #   let(:attributes) { FactoryGirl.attributes_for(:model) }
  #   let(:params) do
  #     {
  #       name: attributes[:name],
  #     }
  #   end
  #
  # Params for a more complicated model with nested associations might look like:
  #
  #   let(:attributes) { FactoryGirl.attributes_for(:model) }
  #   let(:address_attributes) { FactoryGirl.attributes_for(:address) }
  #   let(:state) { FactoryGirl.create(:state) }
  #   let(:params) do
  #     {
  #       name: attributes[:name],
  #       address_attributes: {
  #         line_1: address_attributes[:line_1],
  #         line_2: address_attributes[:line_2],
  #         city: address_attributes[:city],
  #         state: state,
  #       }
  #     }
  #   end
  def to_s
    
  end

end

require_relative "./controller_params/associated_model_setup"
require_relative "./controller_params/attributes_setup"
