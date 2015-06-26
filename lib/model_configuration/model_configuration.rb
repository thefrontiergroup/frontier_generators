require_relative "attribute/factory.rb"
require_relative "attribute.rb"
require_relative "url_builder.rb"

class ModelConfiguration

  attr_reader :model_name, :namespaces, :attributes, :skip_seeds, :skip_ui, :url_builder, :soft_delete

  # Example YAML:
  #   driver:
  #     namespaces: "admin"
  #     soft_delete: false
  #     skip_ui: false
  #     skip_seeds: false
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

  def as_title
    model_name.titleize
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
    @model_name  = hash.keys.first
    @namespaces  = hash[@model_name][:namespaces] || []
    @skip_seeds  = configuration_for(hash[@model_name][:skip_seeds])
    @skip_ui     = configuration_for(hash[@model_name][:skip_ui])
    @soft_delete = configuration_for(hash[@model_name][:soft_delete], default: true)
    @attributes  = (hash[@model_name][:attributes] || []).collect do |name, properties|
      ModelConfiguration::Attribute::Factory.build_attribute_or_association(self, name, properties)
    end
    # TODO: Assert validity of attributes
    @url_builder = ModelConfiguration::UrlBuilder.new(self)
  end

  def configuration_for(attr, options={ default: false })
    attr.nil? ? options[:default] : attr
  end
end
