require_relative "../../frontier"

class FrontierRouteGenerator < Frontier::Generator
  source_root File.expand_path('../templates', __FILE__)

  ROUTES_FILE_PATH = "config/routes.rb"

  attr_reader :route_namespaces

  def scaffold
    unless model.skip_ui?
      @route_namespaces = model.controller_prefixes.each_with_index.collect do |ns, index|
        Frontier::Routes::Namespace.new(ns.as_snake_case, index)
      end
      resource = Frontier::Routes::Resource.new(model, route_namespaces)

      # If we don't need to namespace (can just chuck route in file anywhere) we can use
      # the default rails generator
      unless resource.exists_in_routes_file?(routes_file_content)
        if route_namespaces.empty?
          generate("resource_route", model_with_namespaces)

        # If the namespace block already exists, we should append this route to it.
        else
          normalized   = route_namespaces.last.namespace_string
          denormalized = route_namespaces.last.denormalized_namespace_string
          # Ensure that the namespace is in the normalized form `namespace :jordan do`
          gsub_file(ROUTES_FILE_PATH, denormalized, normalized)
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
      *model.controller_prefixes.map(&:as_snake_case),
      model.model_name
    ].join("/")
  end

  def routes_file_content
    @routes_file_content ||= File.read(ROUTES_FILE_PATH)
  end

end
