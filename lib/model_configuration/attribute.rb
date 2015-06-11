class ModelConfiguration
  class Attribute

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
      # Take options like {one: ':two', abacus: 666} and create collection of strings
      # ["abacus: 666", "one: :two"]
      options_as_strings = options.map {|key, value| "#{key}: #{value}"}.sort
      # Should convert attribute "state" into:
      #   f.input :state_id, collection: State.all
      # With additional options as above you'd get:
      #   f.input :state_id, abacus: 666, collection: State.all, one: :two
      input_declaration = ["f.input #{as_field_name}", *options_as_strings].join(", ")
    end

    def is_enum?
      properties[:type] == "enum"
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

require_relative "attribute/factory_declaration.rb"
require_relative "attribute/migration_component.rb"
require_relative "attribute/validation.rb"