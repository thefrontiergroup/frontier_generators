class ModelConfiguration
  class Attribute

    attr_reader :model_configuration, :name, :properties

    def initialize(model_configuration, name, properties)
      @model_configuration = model_configuration
      @name = name
      @properties = properties
    end

    # some_thing -> "Some thing"
    def capitalized
      name.titleize.capitalize
    end

    def constants
      validations.collect(&:corresponding_constant).compact
    end

    # some_thing -> ":some_thing"
    def as_field_name
      as_symbol
    end

    def as_symbol
      ":#{name}"
    end

    def sortable?
      properties[:sortable]
    end

    def type
      properties[:type]
    end

  # Views

    def as_enum
      # Should look like:
      #   enum attribute_name: ["one", "two"]
      if is_enum?
        enum_options_as_string = properties[:enum_options].collect {|x| "\"#{x}\""}.join(", ")
        "enum #{name}: [#{enum_options_as_string}]"
      else
        raise(ArgumentError, "Attempting to display field #{name} as enum, but is #{type}")
      end
    end

    def as_input(options={})
      ModelConfiguration::Attribute::InputImplementation.new(self).to_s(options)
    end

    def is_enum?
      properties[:type] == "enum"
    end

    def show_on_index?
      properties[:show_on_index].nil? ? true : properties[:show_on_index]
    end

  # Models

    def is_association?
      false
    end

    def validations
      @validations ||= (properties[:validates] || []).collect do |key, args|
        ModelConfiguration::Attribute::Validation.new(self, key, args)
      end
    end

    def validation_implementation
      validation_string = validations.collect(&:as_implementation).join(", ")
      "validates #{as_symbol}, #{validation_string}"
    end

    def validation_required?
      validations.any?
    end

  # Factories

    def as_factory_declaration
      ModelConfiguration::Attribute::FactoryDeclaration.new(self).to_s
    end

  # Migrations

    def as_migration_component
      ModelConfiguration::Attribute::MigrationComponent.new(self).to_s
    end

  end
end

require_relative "attribute/constant.rb"
require_relative "attribute/factory_declaration.rb"
require_relative "attribute/input_implementation.rb"
require_relative "attribute/migration_component.rb"
require_relative "attribute/validation.rb"