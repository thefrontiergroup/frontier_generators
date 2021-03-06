class Frontier::Spec::ObjectAttributesAssertion

  attr_reader :model_or_association, :prefix

  def initialize(model_or_association, prefix=nil)
    @model_or_association = model_or_association
    @prefix = prefix
  end

  # Render a set of assertions that prove that an object has been updated with the attributes
  # generated from Frontier::Spec::ObjectSetup#to_s.
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
  #  expect(model_name.name).to eq(model_attributes[:name])
  #
  #  expect(model_name.address.line_1).to eq(address_attributes[:line_1])
  #  expect(model_name.address.line_2).to eq(address_attributes[:line_2])
  #  expect(model_name.address.city).to eq(address_attributes[:city])
  #  expect(model_name.address.state).to eq(state)
  #
  def to_s
    expectations_for_attributes.join("\n")
  end

private

  # Attribute
  # Association (Not nested)
  # Association (Nested)
  def attributes_and_associations_ordered_by_nested_last
    model_or_association.attributes.select(&:is_attribute?) +
    model_or_association.attributes.select(&:is_association?).partition(&:is_nested?).flatten.reverse
  end

  def expectation(first, second)
    "expect(#{first}).to eq(#{second})"
  end

  def expectations_for_attributes
    # Show attributes first, so they will all be nested under the ModelName comment
    attributes_and_associations_ordered_by_nested_last.select(&:show_on_form?).collect do |attribute|
      expectation_for(attribute)
    end
  end

  def expectation_for(attribute)
    instance_comparison = [
      prefix,
      model_name,
      attribute.name
    ].compact.join(".")

    if attribute.is_attribute?
      # The setup for boolean is always: 'check(attribute_name)' so it will always be set to true
      if attribute.type == "boolean"
        expectation(instance_comparison, "true")
      else
        # EG: expect(model_name.name).to eq(model_attributes[:name])
        expectation(instance_comparison, "#{model_name}_attributes[#{attribute.as_symbol}]")
      end
    else
      if attribute.is_nested?
        # EG:
        #  expect(model_name.address.line_1).to eq(address_attributes[:line_1])
        #  expect(model_name.address.line_2).to eq(address_attributes[:line_2])
        #  expect(model_name.address.city).to eq(address_attributes[:city])
        self.class.new(attribute, [prefix, model_name].compact.join(".")).to_s
      else
        # EG: expect(model_name.address.state).to eq(state)
        expectation(instance_comparison, "#{attribute.name}")
      end
    end
  end

  def model_name
    model_or_association.is_a?(Frontier::Model) ? model_or_association.name.as_singular : model_or_association.model_name
  end

end
