class Frontier::HashSingleLineDecorator

  attr_reader :hash

  def initialize(hash)
    @hash = hash
  end

  # Prints out hash in one line: EG {a: "b", c: {d: 1}}
  def to_s
    hash.collect do |key, value|
      case value
      when Hash
        value = Frontier::HashSingleLineDecorator.new(value).to_s
        value = "{#{value}}"
      when Symbol
        value = ":#{value}"
      when String
        value = "\"#{value}\""
      end
      "#{key}: #{value}"
    end.join(", ")
  end

end
