require_relative "../../frontier"

class FrontierRouteGenerator < Frontier::Generator
  require_relative "./lib/namespace.rb"
  require_relative "./lib/resource.rb"
  source_root File.expand_path('../templates', __FILE__)

  ROUTES_FILE_PATH = "config/routes.rb"

  attr_reader :route_namespaces

  def scaffold
    unless model_configuration.skip_ui?
      @route_namespaces = model_configuration.controller_prefixes.each_with_index.collect do |ns, index|
        FrontierRouteGenerator::Namespace.new(ns.as_snake_case, index)
      end
      resource = FrontierRouteGenerator::Resource.new(model_configuration, namespaces)

      # If we don't need to namespace (can just chuck route in file anywhere), or a namespace
      # block doesn't exist (same thing again) we can use the dumb rails generator
      if route_namespaces.empty? || !routes_file_contains_namespaces?
        generate("resource_route", model_with_namespaces)

      # If the namespace block already exists, we should append this route to it.
      else
        unless resource.exists_in_routes_file?
          normalized   = route_namespaces.last.namespace_string
          unnormalized = route_namespaces.last.unnormalized_namespace_string
          # Ensure that the namespace is in the normalized form `namespace :jordan do`
          gsub_file(ROUTES_FILE_PATH, unnormalized, normalized)
          # Append the route to the normalized namespace. EG:
          # namespace :admin do
          #   resources :jordan
          # end
          gsub_file(ROUTES_FILE_PATH, normalized, "#{normalized}\n#{resource.route_string}")
        end
      end
    end
  end

private

  # EG: admin/user
  def model_with_namespaces
    [
      *model_configuration.controller_prefixes.map(&:as_snake_case),
      model_configuration.model_name
    ].join("/")
  end

  def routes_file_contains_namespaces?
    route_namespaces.last.exists_in_routes_file?
  end

end
