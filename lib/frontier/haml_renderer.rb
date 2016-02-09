class Frontier::HamlRenderer

  attr_reader :string

  def initialize(string)
    @string = string
  end

  def render(number_of_indents)
    string.split("\n").map {|string_component| hamelize_string(string_component, number_of_indents)}.join("\n")
  end

private

  # Convert:
  #   * "doodle" to "= doodle"
  #   * "  yolo" to "  = yolo"
  def component_prependend_with_haml(string_component)
    string_component.sub(string_component.strip, "= #{string_component.strip}")
  end

  def hamelize_string(string_component, number_of_indents)
    [
      indents_as_whitespace(number_of_indents),
      component_prependend_with_haml(string_component)
    ].join
  end

  def indents_as_whitespace(number_of_indents)
    Array.new(number_of_indents, "  ").join
  end

end
