class Frontier::Attribute::FactoryDeclaration

  attr_reader :attribute

  def initialize(attribute)
    @attribute = attribute
  end

  def to_s
    "#{attribute.name} { #{data_for_attribute} }"
  end

private

  def data_for_attribute
    if constant = attribute.constants.first
      "#{constant.name}.sample"
    else
      attributes_based_on_type
    end
  end

  def attributes_based_on_type
    case attribute.type
    when "boolean"
      "[true, false].sample"
    when "date"
      [date_data, "to_date"].join(".")
    when "datetime"
      date_data
    when "decimal", "integer"
      number_data
    when "enum"
      enum_data
    when "string"
      string_data
    when "text"
      text_data
    else
      raise(ArgumentError, "Unsupported Type: #{attribute.type}")
    end
  end

# Specific Types

  def date_data
    "5.days.from_now"
  end

  def enum_data
    "#{attribute.model.as_constant}.#{attribute.name.pluralize}.keys.sample"
  end

  def number_data
    Frontier::Attribute::FactoryDeclaration::Number.new(attribute).to_s
  end

  def text_data
    "FFaker::Lorem.paragraph(5)"
  end

  def string_data
    Frontier::Attribute::FactoryDeclaration::String.new(attribute).to_s
  end

end

require_relative "./factory_declaration/number"
require_relative "./factory_declaration/string"
