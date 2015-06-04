class ModelConfiguration
  class Attribute

    require_relative "attribute/factory_declaration.rb"

    attr_reader :name, :properties

    def initialize(name, properties)
      @name = name
      @properties = properties
    end

    # some_thing -> "Some thing"
    def capitalized
      name.titleize.capitalize
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

    def as_input
      "f.input #{as_field_name}"
    end

  # Models

    def is_association?
      false
    end

    def validations
      @validations ||= (properties[:validates] || []).collect do |key, args|
        ModelConfiguration::Validation.new(self, key, args)
      end
    end

    def validation_implementation
      validation_string = validations.collect(&:implementation).join(", ")
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