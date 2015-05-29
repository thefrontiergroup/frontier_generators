require_relative "../frontier_scaffold/lib/model_configuration.rb"

class FrontierRouteGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  ROUTES_FILE_PATH = "config/routes.rb"

  attr_accessor :model_configuration

  def scaffold
    self.model_configuration = ModelConfiguration.new(ARGV[0])

    # If we don't need to namespace (can just chuck route in file anywhere), or a namespace
    # block doesn't exist (same thing again) we can use the dumb rails generator
    if model_configuration.namespaces.empty? || !routes_file_contains_namespace?
      generate("resource_route", model_with_namespaces)
    # If the namespace block already exists, we should append this route to it.
    else
      route_for_resource = "#{tabs_before_route}resources :#{model_configuration.model_name.pluralize}"
      unless File.read(ROUTES_FILE_PATH).include?(route_for_resource)
        gsub_file(ROUTES_FILE_PATH, "namespace(:admin) do", "namespace :admin do")
        gsub_file(ROUTES_FILE_PATH, "namespace :admin do", "namespace :admin do\n#{route_for_resource}")
      end
    end
  end

private

  def model_with_namespaces
    [*model_configuration.namespaces, model_configuration.model_name].join("/")
  end

  # Finds:
  #   * namespace :name
  #   * namespace(:name)
  def namespace_regexp(namespace)
    /namespace(\(|\s):#{namespace}/
  end

  # Calculate the amount of tabs we'll need to indent the route by
  # Consider a typical routes file:
  #
  # Rails.application.routes.draw do
  # 1-namespace(:first) do
  # 1-2-namespace(:second) do
  # 1-2-3-resources :dongs
  # 1-2-end
  # 1-end
  # end
  def number_of_tabs_in_namespace
    1 + model_configuration.namespaces.count
  end

  def routes_file_contains_namespace?
    deepest_namespace = model_configuration.namespaces.last
    route_file_content =~ namespace_regexp(deepest_namespace)
  end

  def route_file_content
    @route_file_content ||= File.read("config/routes.rb")
  end

  def tabs_before_route
    @tabs_before_route ||= Array.new(number_of_tabs_in_namespace, "  ").join("")
  end

end
