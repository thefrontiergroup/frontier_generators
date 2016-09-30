class Frontier::Model

  attr_reader *[
    :attributes,
    :authorization,
    :controller_prefixes,
    :name,
    :skip_factory,
    :skip_model,
    :skip_policies,
    :skip_seeds,
    :skip_ui,
    :soft_delete,
    :url_builder,
    :view_paths
  ]

  def initialize(attributes)
    # Basic data about the model
    model_name = attributes.keys.first
    @controller_prefixes = attributes[model_name][:controller_prefixes] || []
    unless controller_prefixes.is_a?(Array)
      raise(ArgumentError, "Invalid value for 'controller_prefixes' passed through: #{controller_prefixes}. Must be an array. EG: [:admin]")
    end
    @controller_prefixes = @controller_prefixes.map {|prefix| Frontier::ControllerPrefix.new(prefix)}
    # TODO: Assert validity of attributes
    @attributes = (attributes[model_name][:attributes] || []).collect do |name, properties|
      Frontier::Attribute::Factory.build_attribute_or_association(self, name, properties)
    end

    # Configuration of generated items
    @authorization = configuration_for(attributes[model_name][:authorization], default: "pundit")
    @skip_factory  = configuration_for(attributes[model_name][:skip_factory])
    @skip_model    = configuration_for(attributes[model_name][:skip_model])
    @skip_seeds    = configuration_for(attributes[model_name][:skip_seeds])
    @skip_policies = configuration_for(attributes[model_name][:skip_policies])
    parse_skip_ui_options(configuration_for(attributes[model_name][:skip_ui]))
    @soft_delete   = configuration_for(attributes[model_name][:soft_delete], default: true)

    # Additional utility items
    @url_builder = Frontier::UrlBuilder.new(self)
    @view_paths  = Frontier::Model::ViewPaths.new(attributes[model_name][:view_path_attributes])

    # Ensure model name is a string
    @name = Frontier::Model::Name.new(model_name.to_s)
  end

  def attributes_only
    attributes.select(&:is_attribute?)
  end

  def associations
    attributes.select(&:is_association?)
  end

  # The primary attribute is used for:
  #   * Model#to_s (and spec)
  #   * Determining whether or not an instance of the model is visible in feature specs
  def primary_attribute
    attributes.find(&:is_primary?) || attributes.first
  end

  [
    :skip_factory,
    :skip_model,
    :skip_policies,
    :skip_seeds,
    :skip_ui
  ].each do |method_name|

    define_method("#{method_name}?") do
      !!send(method_name)
    end

  end

  def show_index?
    !@skip_index && !skip_ui?
  end

  def show_delete?
    !@skip_delete && !skip_ui?
  end

  def show_create?
    !@skip_create && !skip_ui?
  end

  def show_update?
    !@skip_update && !skip_ui?
  end

  def using_pundit?
    authorization.downcase == "pundit"
  end

private

  def configuration_for(attribute, options={ default: false })
    attribute.nil? ? options[:default] : attribute
  end

  def parse_skip_ui_options(skip_ui_raw)
    if skip_ui_raw.is_a?(Array)
      @skip_index = skip_ui_raw.include?("index")
      @skip_delete = skip_ui_raw.include?("delete")
      @skip_create = skip_ui_raw.include?("create")
      @skip_update = skip_ui_raw.include?("update")
    else
      @skip_ui = skip_ui_raw
    end
  end
end

require_relative "model/name"
require_relative "model/view_paths"
