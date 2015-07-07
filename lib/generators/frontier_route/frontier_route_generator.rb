require_relative "../../model_configuration/model_configuration"

class FrontierRouteGenerator < Rails::Generators::NamedBase
  require_relative "./lib/namespace.rb"
  require_relative "./lib/resource.rb"
  source_root File.expand_path('../templates', __FILE__)

  ROUTES_FILE_PATH = "config/routes.rb"

  attr_accessor :model_configuration
  attr_reader :namespaces

  def scaffold
    self.model_configuration = ModelConfiguration.new(ARGV[0])

    unless model_configuration.skip_ui?
      # model_configuration.namespaces will be an array. EG: ["admin", "groups"]
      @namespaces = model_configuration.namespaces.each_with_index.collect do |ns, index|
        FrontierRouteGenerator::Namespace.new(ns, index)
      end
      resource = FrontierRouteGenerator::Resource.new(model_configuration, namespaces)

      # If we don't need to namespace (can just chuck route in file anywhere), or a namespace
      # block doesn't exist (same thing again) we can use the dumb rails generator
      if model_configuration.namespaces.empty? || !routes_file_contains_namespaces?
        generate("resource_route", model_with_namespaces)
      # If the namespace block already exists, we should append this route to it.
      else
        unless resource.exists_in_routes_file?
          normalized   = namespaces.last.namespace_string
          unnormalized = namespaces.last.unnormalized_namespace_string
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

  def model_with_namespaces
    [*model_configuration.namespaces, model_configuration.model_name].join("/")
  end

  def routes_file_contains_namespaces?
    namespaces.last.exists_in_routes_file?
  end

end
