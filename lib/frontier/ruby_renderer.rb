class Frontier::RubyRenderer

  include Frontier::IndentRenderer

  attr_reader :string

  def initialize(string)
    @string = string
  end

  def render(number_of_indents)
    string.split("\n").map {|string_component| rubyify_string(string_component, number_of_indents)}.join("\n")
  end

private

  def rubyify_string(string_component, number_of_indents)
    if string_component.present?
      render_with_indent(number_of_indents, string_component)
    else
      string_component
    end
  end

end
