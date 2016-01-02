class ModelConfiguration::UrlBuilder

  attr_reader :model_configuration

  def initialize(model_configuration)
    @model_configuration = model_configuration
  end

  def index_path
    "#{plural_resource_with_namespaces}"
  end

  def new_path
    "new_#{singular_resource_with_namespaces}"
  end

  def edit_path
    "edit_#{singular_resource_with_namespaces}(#{model_configuration.model_name})"
  end

  def failed_edit_path(resource_name)
    resource_name ||= model_configuration.model_name
    "#{singular_resource_with_namespaces}(#{resource_name})"
  end

  def delete_path
    "#{singular_resource_with_namespaces}(#{model_configuration.model_name})"
  end

private

  # Namespace: Admin::Dongle::Resource
  # Becomes admin_dongle_resources_path
  def plural_resource_with_namespaces
    resource_with_namespaces(model_configuration.model_name.pluralize)
  end

  # Namespace: Admin::Dongle::Resource
  # Becomes admin_dongle_resource_path
  def singular_resource_with_namespaces
    resource_with_namespaces(model_configuration.model_name)
  end

  def resource_with_namespaces(resource)
    [*model_configuration.namespaces, resource, "path"].join("_")
  end

end
