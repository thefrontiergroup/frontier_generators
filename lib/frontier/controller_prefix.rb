class Frontier::ControllerPrefix

  attr_reader :name

  # EG: "admin", or "@client"
  def initialize(name)
    @name = name
  end

  # ":admin" or "@client"
  def as_form_component
    if namespace?
      ":#{name}"
    else
      name
    end
  end

  def namespace?
    !nested_model?
  end

  def nested_model?
    name[0] == "@"
  end

end
