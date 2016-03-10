require_relative "attribute.rb"

class Frontier::Association < Frontier::Attribute

  include Frontier::ErrorReporter

  attr_reader :attributes, :form_type

  ID_REGEXP = /_id\z/

  def initialize(model_configuration, name, properties)
    super

    # Convert:
    #   address_id -> address
    #   address -> address
    @name = name.to_s.sub(ID_REGEXP, "")
    @attributes = parse_attributes(properties[:attributes] || [])
    @form_type  = parse_form_type(properties[:form_type])
  end

  def associations
    attributes.select(&:is_association?)
  end

  def association_class
    if properties[:class_name].present?
      properties[:class_name]
    else
      name.camelize
    end
  end
  alias as_constant association_class

  def as_factory_name
    ":#{association_class.underscore}"
  end

  # some_thing_id -> ":some_thing_id"
  # some_thing -> ":some_thing_id"
  def as_field_name
    "#{as_symbol}_id"
  end

  def is_association?
    true
  end

  def is_nested?
    form_type == "inline"
  end

  alias model_name name

  # Factories

  def as_factory_declaration
    Frontier::Association::FactoryDeclaration.new(self).to_s
  end

private

  def parse_attributes(attributes_properties)
    attributes_properties.collect do |name, attribute_or_association_properties|
      Frontier::Attribute::Factory.build_attribute_or_association(self, name, attribute_or_association_properties)
    end
  end

  def parse_form_type(form_type_property)
    case form_type_property.to_s
    when "inline", "select"
      form_type_property.to_s
    else
      report_error("Unknown form type: '#{form_type_property.to_s}', defaulting to 'select'")
      "select"
    end
  end

end

require_relative "association/factory_declaration.rb"
require_relative "association/feature_spec_assignment.rb"
require_relative "association/model_implementation.rb"
