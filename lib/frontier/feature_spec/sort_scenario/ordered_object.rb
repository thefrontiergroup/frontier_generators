class Frontier::FeatureSpec::SortScenario::OrderedObject

  attr_reader :model_configuration, :attribute_or_association

  def initialize(attribute_or_association)
    @model_configuration      = attribute_or_association.model_configuration
    @attribute_or_association = attribute_or_association
  end

  def first
    Frontier::FactoryGirlSupport::Declaration.new(:create, model_configuration).to_s(first_options)
  end

  def second
    Frontier::FactoryGirlSupport::Declaration.new(:create, model_configuration).to_s(second_options)
  end

private

  def first_options
    {attribute_or_association.name => first_value}
  end

  def second_options
    {attribute_or_association.name => second_value}
  end

  def first_value
    object_values.first
  end

  def second_value
    object_values.last
  end

  def object_values
    case attribute_or_association.type
    when "boolean"
      [false, true]
    when "datetime", "date"
      ["10.days.ago", "5.days.ago"]
    when "decimal", "integer"
      [10, 100]
    when "string", "text"
      ["\"Alpha\"", "\"Bravo\""]
    else
      ["\"Alpha\"", "\"Bravo\""]
    end
  end

end
