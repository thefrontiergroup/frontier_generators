class Frontier::FeatureSpec::SortScenario

  attr_reader :model_configuration, :attribute_or_association

  def initialize(attribute_or_association)
    @model_configuration      = attribute_or_association.model_configuration
    @attribute_or_association = attribute_or_association
  end

  def to_s
    raw = <<STRING
scenario "sorting by '#{attribute_or_association.name}'" do
  second = #{ordered_object.second}
  first  = #{ordered_object.first}

  #{visit_index_method}

  # Ascending
  click_link("#{attribute_or_association.as_table_heading}")
  #{order_expectation_method_name}(first, second)

  # Descending
  click_link("#{attribute_or_association.as_table_heading}")
  #{order_expectation_method_name}(second, first)
end
STRING
    raw.rstrip
  end

private

  def ordered_object
    @ordered_object ||= Frontier::FeatureSpec::SortScenario::OrderedObject.new(attribute_or_association)
  end

  def order_expectation_method_name
    Frontier::FeatureSpec::OrderExpectationMethod.new(model_configuration).method_name
  end

  def visit_index_method
    Frontier::FeatureSpec::VisitIndexMethod.new(model_configuration).method_name
  end

end

require_relative "./sort_scenario/ordered_object"
