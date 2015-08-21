class ModelConfiguration
  class Attribute

    attr_reader :model_configuration, :is_primary, :name, :properties

    def initialize(model_configuration, name, properties)
      @model_configuration = model_configuration
      @name = name.to_s
      @properties = properties
      @is_primary = @properties[:primary] == true
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

    def is_primary?
      !!@is_primary
    end

    def sortable?
      properties[:sortable]
    end

    def type
      properties[:type].to_s
    end

  # Views

    def as_enum
      # Should look like:
      #   enum attribute_name: ["one", "two"]

      if is_enum?
        if (enum_options = properties[:enum_options]).present?
          enum_options_as_hash = Frontier::HashDecorator.new array_as_hash(enum_options)
          "enum #{name}: {#{enum_options_as_hash}}"
        else
          raise(ArgumentError, "No enum_options provided for attribute: #{name}")
        end
      else
        raise(ArgumentError, "Attempting to display field #{name} as enum, but is #{type}")
      end
    end

    def is_enum?
      properties[:type] == "enum"
    end

    def show_on_index?
      properties[:show_on_index].nil? ? true : properties[:show_on_index]
    end

    # index refers to the index.html.haml template, nothing to do with DB.
    def as_index_string
      case type
        when "text" then "truncate(#{model_configuration.model_name}.#{name}, length: 30)"
        else "#{model_configuration.model_name}.#{name}"
      end
    end

  # Models

    def is_association?
      false
    end

    def validations
      @validations ||= (properties[:validates] || []).collect do |key, args|
        ModelConfiguration::Attribute::Validation::Factory.new.build(self, key, args)
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

  private

    def array_as_hash(array)
      Hash[array.zip(0..array.length)]
    end
  end
end

require_relative "attribute/constant.rb"
require_relative "attribute/factory_declaration.rb"
require_relative "attribute/migration_component.rb"
require_relative "attribute/validation/factory.rb"