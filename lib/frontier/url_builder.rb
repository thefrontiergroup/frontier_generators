class Frontier::UrlBuilder

  include Frontier::ModelConfigurationProperty

  def index_path
    "#{plural_resource_route_with_controller_prefixes}#{route_objects(show_local: false)}"
  end

  def new_path
    "new_#{singular_resource_route_with_controller_prefixes}#{route_objects(show_local: false)}"
  end

  def edit_path
    "edit_#{singular_resource_route_with_controller_prefixes}#{route_objects(show_local: true)}"
  end

  def delete_path
    "#{singular_resource_route_with_controller_prefixes}#{route_objects(show_local: true)}"
  end

private

  # Namespaces do nothing, nested models add an ivar.
  def route_objects(show_local:)
    components = [
      *model_configuration.controller_prefixes.map(&:as_route_object),
      (model_configuration.model_name if show_local)
    ].compact

    if components.any?
      "(#{components.join(", ")})"
    end
  end

  # Namespace: Admin::Dongle::Resource
  # Becomes admin_dongle_resources_path
  def plural_resource_route_with_controller_prefixes
    resource_with_controller_prefixes(model_configuration.model_name.pluralize)
  end

  # Namespace: Admin::Dongle::Resource
  # Becomes admin_dongle_resource_path
  def singular_resource_route_with_controller_prefixes
    resource_with_controller_prefixes(model_configuration.model_name)
  end

  def resource_with_controller_prefixes(resource)
    [
      *model_configuration.controller_prefixes.map(&:as_route_component),
      resource,
      "path"
    ].join("_")
  end

end
