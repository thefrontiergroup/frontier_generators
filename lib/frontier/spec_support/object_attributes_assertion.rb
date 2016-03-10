class Frontier::SpecSupport::ObjectAttributesAssertion

  attr_reader :model_configuration_or_association, :prefix

  def initialize(model_configuration_or_association, prefix=nil)
    @model_configuration_or_association = model_configuration_or_association
    @prefix = prefix
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
    [
      "# #{model_configuration_or_association.as_constant} assertions",
      expectations_for_attributes
    ].join("\n")
  end

private

  # Attribute
  # Association (Not nested)
  # Association (Nested)
  def attributes_and_associations_ordered_by_nested_last
    model_configuration_or_association.attributes.select(&:is_attribute?) +
    model_configuration_or_association.attributes.select(&:is_association?).partition(&:is_nested?).flatten.reverse
  end

  def expectation(first, second)
    "expect(#{first}).to eq(#{second})"
  end

  def expectations_for_attributes
    # Show attributes first, so they will all be nested under the ModelName comment
    attributes_and_associations_ordered_by_nested_last.collect do |attribute|
      expectation_for(attribute)
    end
  end

  def expectation_for(attribute)
    instance_comparison = [
      prefix,
      model_configuration_or_association.model_name,
      attribute.name
    ].compact.join(".")

    if attribute.is_attribute?
      # EG: expect(model_name.name).to eq(model_attributes[:name])
      expectation(instance_comparison, "#{model_configuration_or_association.model_name}_attributes[#{attribute.as_symbol}]")
    else
      if attribute.is_nested?
        # EG:
        #  expect(model_name.address.line_1).to eq(address_attributes[:line_1])
        #  expect(model_name.address.line_2).to eq(address_attributes[:line_2])
        #  expect(model_name.address.city).to eq(address_attributes[:city])
        self.class.new(attribute, [prefix, model_configuration_or_association.model_name].compact.join(".")).to_s
      else
        # EG: expect(model_name.address.state).to eq(state)
        expectation(instance_comparison, "#{attribute.name}")
      end
    end
  end

end
