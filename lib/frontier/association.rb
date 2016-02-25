require_relative "attribute.rb"

class Frontier::Association < Frontier::Attribute

  ID_REGEXP = /_id\z/

  def association_class
    if properties[:class_name].present?
      properties[:class_name]
    else
      without_id.camelize
    end
  end

  def as_factory_name
    ":#{association_class.underscore}"
  end

  # some_thing_id -> ":some_thing_id"
  # some_thing -> ":some_thing_id"
  def as_field_name
    if name =~ ID_REGEXP
      as_symbol
    else
      "#{as_symbol}_id"
    end
  end

  # some_thing_id -> ":some_thing"
  # some_thing -> ":some_thing"
  def as_symbol_without_id
    ":#{without_id}"
  end

  def is_association?
    true
  end

  # Factories

  def as_factory_declaration
    Frontier::Association::FactoryDeclaration.new(self).to_s
  end

private

  def without_id
    name.sub(ID_REGEXP, "")
  end

end

require_relative "association/factory_declaration.rb"
require_relative "association/feature_spec_assignment.rb"
require_relative "association/model_implementation.rb"
