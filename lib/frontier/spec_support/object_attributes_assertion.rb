class Frontier::SpecSupport::ObjectAttributesAssertion

  attr_reader :model_configuration

  def initialize(model_configuration)
    @model_configuration = model_configuration
  end

  # Render a set of assertions that prove that an object has been updated with the attributes
  # generated from Frontier::SpecSupport::ObjectSetup#to_s.
  #
  # For the following attributes:
  #
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
  #
  # We would want to assert:
  #
  #  # ModelName assertions
  #  expect(model_name.name).to eq(model_attributes[:name])
  #  # Address asertions
  #  expect(model_name.address.line_1).to eq(address_attributes[:line_1])
  #  expect(model_name.address.line_2).to eq(address_attributes[:line_2])
  #  expect(model_name.address.city).to eq(address_attributes[:city])
  #  expect(model_name.address.state).to eq(state)
  #
  def to_s
  end

end
