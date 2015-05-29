require_relative "./model_configuration/attribute"
require_relative "./model_configuration/url_builder"
require_relative "./model_configuration/validation"

class ModelConfiguration

  attr_reader :model_name, :namespaces, :attributes, :skip_ui, :url_builder

  # Example YAML:
  #   drive:
  #     namespace: "admin"
  #     attributes:
  #       name:
  #         type: "string"
  #         sortable: true
  #         searchable: true
  #       contact_number:
  #         type: "string"
  #         sortable: false
  #         searchable: false
  def initialize(file_path)
    parsed_yaml = YAML.load(File.open(file_path))
    if parsed_yaml.keys.count > 1
      raise(ArgumentError, "Multiple models currently not supported")
    else
      assign_attributes_from_model_configuration(parsed_yaml.with_indifferent_access)
    end
  end

  def as_constant
    "#{model_name.camelize}"
  end

  def as_symbol
    ":#{model_name}"
  end

  def as_symbol_collection
    ":#{model_name.pluralize}"
  end

  def ivar_collection
    "@#{model_name.pluralize}"
  end

  def ivar_instance
    "@#{model_name}"
  end

  def primary_attribute
    attributes.first
  end

private

  def assign_attributes_from_model_configuration(hash)
    @model_name = hash.keys.first
    @namespaces = hash[@model_name][:namespaces] || []
    @skip_ui    = hash[@model_name][:skip_ui] || false
    @attributes = hash[@model_name][:attributes].collect do |name, properties|
      ModelConfiguration::Attribute.new(name, properties)
    end
    # TODO: Assert validity of attributes
    @url_builder = ModelConfiguration::UrlBuilder.new(self)
  end

end