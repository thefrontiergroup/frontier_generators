class Frontier::SpecSupport::LetStatement

  attr_reader :key, :body

  def initialize(key, body)
    @key = key
    @body = body
  end

  # Should pump out something like:
  #
  #   let(:key) { body }
  #
  # or:
  #
  #   let(:key) do
  #     body
  #   end
  #
  def to_s(options={})
    has_bang = options[:has_bang] || false
    is_multiline  = options[:is_multiline] || false

    "#{let(has_bang)} #{let_block(is_multiline)}"
  end

private

  def let(has_bang)
    "let#{has_bang ? "!" : nil}(:#{key})"
  end

  def let_block(is_multiline)
    if is_multiline
      "do\n  #{body.lstrip}\nend"
    else
      "{ #{body} }"
    end
  end

end
