require_relative "factory_attribute_declaration.rb"
require_relative "validation_spec_string.rb"
require_relative "validation_string.rb"

class ModelConfiguration
  class Attribute
    attr_reader :name, :properties

    def initialize(name, properties)
      @name = name
      @properties = properties
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

  # Models

    def validations
      @validations ||= properties[:validates].collect do |key, args|
        ModelConfiguration::Validation.new(self, key, args)
      end
    end

    def validation_required?
      validations.any?
    end

    def validation_spec
      if validations.any?
        ModelConfiguration::ValidationSpecString.for(self)
      else
        ""
      end
    end

  # Factories

    def factory_declaration
      ModelConfiguration::FactoryAttributeDeclaration.for(self)
    end

  # Migrations

    def as_migration_component
      [name, properties[:type]].compact.join(":")
    end

  end
end