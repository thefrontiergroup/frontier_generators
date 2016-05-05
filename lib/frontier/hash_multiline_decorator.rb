class Frontier::HashMultilineDecorator

  include Frontier::IndentRenderer

  attr_reader :depth, :hash

  def initialize(hash, depth=0)
    @depth = depth
    @hash = hash
  end

  # Prints out hash in multiple line, EG:
  #
  #   {a: 1, "b" => 2, c: {d: "some_object"}, e: {f: {"g" => '"some_string"'}}}
  #
  # becomes:
  #
  #   {
  #     a: 1,
  #     b: 2,
  #     c: {
  #       d: some_object,
  #       e: {
  #         f: {
  #           g: "some_string",
  #         }
  #       }
  #     }
  #   }
  #
  def to_s(indent_level=0)
    if depth == 0
      [
        render_with_indent(indent_level, "{"),
        hash_contents(indent_level+1),
        render_with_indent(indent_level, "}")
      ].join("\n")
    else
      hash_contents(indent_level)
    end
  end

private

  def hash_contents(indent_level)
    hash.collect do |key, value|
      case value
      when Hash
        value = Frontier::HashMultilineDecorator.new(value, depth+1).to_s(indent_level)
        value = "{\n#{value}\n#{render_with_current_indent(indent_level, "}")}"
      when String
        value = value
      end
      render_with_current_indent(indent_level, "#{key}: #{value}")
    end.join(",\n")
  end

  def render_with_current_indent(indent_level, content)
    render_with_indent(depth+indent_level, content)
  end

end
