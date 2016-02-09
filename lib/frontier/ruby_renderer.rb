class Frontier::RubyRenderer

  attr_reader :string

  def initialize(string)
    @string = string
  end

  def render(number_of_indents)
    string.split("\n").map {|string_component| rubyify_string(string_component, number_of_indents)}.join("\n")
  end

private

  def rubyify_string(string_component, number_of_indents)
    [
      indents_as_whitespace(number_of_indents),
      string_component
    ].join
  end

  def indents_as_whitespace(number_of_indents)
    Array.new(number_of_indents, "  ").join
  end

end
