class FrontierRouteGenerator::Namespace

  ROUTES_FILE_PATH = "config/routes.rb"

  attr_reader :name, :depth

  # controller_prefixes: ["admin", "groups"]
  #
  # Would generate two FrontierRouteGenerator::Namespaces:
  #   name: "admin", depth: 0
  #   name: "groups", depth: 1
  def initialize(name, depth)
    @name = name
    @depth = depth
  end

  def exists_in_routes_file?
    (route_file_content =~ namespace_regexp(name)).present?
  end

  def namespace_string
    "namespace :#{name} do"
  end

  def unnormalized_namespace_string
    "namespace(:#{name}) do"
  end

private

  # Finds:
  #   * namespace :name
  #   * namespace(:name)
  def namespace_regexp(namespace)
    /namespace(\(|\s):#{namespace}/
  end

  def route_file_content
    @route_file_content ||= File.read(ROUTES_FILE_PATH)
  end

end
