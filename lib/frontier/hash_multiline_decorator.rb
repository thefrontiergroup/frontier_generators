class Frontier::HashMultilineDecorator

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
  def to_s
    if depth == 0
      "{\n#{hash_contents}\n}"
    else
      hash_contents
    end
  end

private

  def hash_contents
    hash.collect do |key, value|
      case value
      when Hash
        value = Frontier::HashMultilineDecorator.new(value, depth+1).to_s
        value = "{\n#{value}\n#{current_indent}}"
      when String
        value = value
      end
      "#{current_indent}#{key}: #{value}"
    end.join(",\n")
  end

  def current_indent
    Array.new(depth+1, "  ").join
  end

end
