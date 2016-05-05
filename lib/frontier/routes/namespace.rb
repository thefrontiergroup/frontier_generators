class Frontier::Routes::Namespace

  attr_reader :name, :depth

  # controller_prefixes: ["admin", "groups"]
  #
  # Would generate two Frontier::Routes::Namespaces:
  #   name: "admin", depth: 0
  #   name: "groups", depth: 1
  def initialize(name, depth)
    @name = name
    @depth = depth
  end

  def namespace_string
    "namespace :#{name} do"
  end

  def denormalized_namespace_string
    "namespace(:#{name}) do"
  end

end
