class Frontier::Routes::Resource

  attr_reader :model_configuration, :namespaces

  # model_configuration: Instance of Frontier::ModelConfiguration
  # namespaces: Collection of Frontier::Routes::Namespace
  def initialize(model_configuration, namespaces)
    @model_configuration = model_configuration
    @namespaces = namespaces
  end

  def exists_in_routes_file?(routes_file_contents)
    !!(routes_file_contents =~ route_regexp)
  end

  def route_string
    "#{preceding_whitespace}resources #{model_configuration.as_symbol_collection}"
  end

private

  def preceding_whitespace
    @preceding_whitespace ||= Array.new(number_of_tabs_before_route, "  ").join("")
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
  def number_of_tabs_before_route
    1 + namespaces.count
  end

  def route_regexp
    /#{preceding_whitespace}resources(\(|\s)#{model_configuration.as_symbol_collection}/
  end

end
