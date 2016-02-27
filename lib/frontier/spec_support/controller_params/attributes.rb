class Frontier::SpecSupport::ControllerParams::Attributes

  attr_reader :model_configuration

  def initialize(model_configuration)
    @model_configuration = model_configuration
  end

  # Return a string that represents the attributes that would be used in the setup for a controller
  # spec. EG:
  #
  #   let(:model_name_params) do
  #     {
  #       address_id: address.id,
  #       name: attributes[:name],
  #       address_attributes: {
  #         line_1: address_attributes[:line_1],
  #         line_2: address_attributes[:line_2],
  #         city: address_attributes[:city],
  #         state: state,
  #       }
  #     }
  #   end
  #
  def to_s
    Frontier::SpecSupport::LetStatement.new("#{model_configuration.model_name}_params", let_body).to_s({is_multiline: true})
  end

private

  def let_body
    attributes_hash = Frontier::SpecSupport::ControllerParams::AttributesHash.new(model_configuration).to_hash
    Frontier::HashMultilineDecorator.new(attributes_hash).to_s(1)
  end

end
