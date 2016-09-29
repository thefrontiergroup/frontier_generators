module Frontier::ModelProperty

  attr_reader :model

  def initialize(model)
    @model = model
  end

protected

  def render_with_indent(indent_level, content)
    Frontier::RubyRenderer.new(content).render(indent_level)
  end

end
