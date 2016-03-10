module Frontier::IndentRenderer

protected

  def render_with_indent(indent_level, content)
    Array.new(indent_level, "  ").join + content
  end

end
