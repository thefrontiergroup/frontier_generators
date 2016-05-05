module Frontier::ModelConfigurationProperty

  attr_reader :model_configuration

  def initialize(model_configuration)
    @model_configuration = model_configuration
  end

protected

  def render_with_indent(indent_level, content)
    Frontier::RubyRenderer.new(content).render(indent_level)
  end

end
