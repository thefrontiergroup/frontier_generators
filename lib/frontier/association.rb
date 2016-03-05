require_relative "attribute.rb"

class Frontier::Association < Frontier::Attribute

  ID_REGEXP = /_id\z/

  def initialize(model_configuration, name, properties)
    super

    # Convert:
    #   address_id -> address
    #   address -> address
    @name = name.to_s.sub(ID_REGEXP, "")
  end

  def association_class
    if properties[:class_name].present?
      properties[:class_name]
    else
      name.camelize
    end
  end

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

  # Factories

  def as_factory_declaration
    Frontier::Association::FactoryDeclaration.new(self).to_s
  end

end

require_relative "association/factory_declaration.rb"
require_relative "association/feature_spec_assignment.rb"
require_relative "association/model_implementation.rb"
