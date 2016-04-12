class Frontier::FeatureSpec::SortScenario

  attr_reader :model_configuration, :attribute_or_association

  def initialize(model_configuration, attribute_or_association)
    @model_configuration      = model_configuration
    @attribute_or_association = attribute_or_association
  end

  def to_s
    raw = <<STRING
scenario "sorting by '#{attribute_or_association.name}'" do
  second = #{ordered_object.second}
  first  = #{ordered_object.first}

  visit_index

  # Descending
  click_link("#{attribute_or_association.as_table_heading}")
  expect_#{model_configuration.as_collection}_to_be_ordered(second, first)

  # Ascending
  click_link("#{attribute_or_association.as_table_heading}")
  expect_#{model_configuration.as_collection}_to_be_ordered(first, second)
end
STRING
    raw.rstrip
  end

private

  def ordered_object
    @ordered_object ||= Frontier::FeatureSpec::SortScenario::OrderedObject.new(model_configuration, attribute_or_association)
  end

end

require_relative "./sort_scenario/ordered_object"
