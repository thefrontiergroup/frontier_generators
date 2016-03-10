class Frontier::SpecSupport::ObjectSetup::Attributes

  attr_reader :model_configuration

  def initialize(model_configuration)
    @model_configuration = model_configuration
  end

  # Return a string that represents the attributes that would be used in the setup for a controller
  # spec. EG:
  #
  #   let(:attributes) do
  #     {
  #       address_id: address.id,
  #       name: model_name_attributes[:name],
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
    Frontier::SpecSupport::LetStatement.new("attributes", let_body).to_s({is_multiline: true})
  end

private

  def let_body
    attributes_hash = Frontier::SpecSupport::ObjectSetup::AttributesHash.new(model_configuration).to_hash
    Frontier::HashMultilineDecorator.new(attributes_hash).to_s(1)
  end

end
