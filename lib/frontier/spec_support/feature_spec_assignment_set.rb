class Frontier::SpecSupport::FeatureSpecAssignmentSet

  attr_reader :model_configuration_or_association

  def initialize(model_configuration_or_association)
    @model_configuration_or_association = model_configuration_or_association
  end

  # Render a set of form assignments for the attributes and associations of a model using
  # Capybara syntax.
  #
  def to_s
    [
      "# #{model_configuration_or_association.as_constant} assignments",
      assignments_for_attributes
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

  def assignments_for_attributes
    # Show attributes first, so they will all be nested under the ModelName comment
    attributes_and_associations_ordered_by_nested_last.collect do |attribute|
      assignment_for(attribute)
    end
  end

  def assignment_for(attribute_or_association)
    if attribute_or_association.is_association? && attribute_or_association.is_nested?
      Frontier::SpecSupport::FeatureSpecAssignmentSet.new(attribute_or_association).to_s
    else
      Frontier::FeatureSpecAssignment.new(attribute_or_association).to_s("#{model_configuration_or_association.model_name}_attributes")
    end
  end

end
