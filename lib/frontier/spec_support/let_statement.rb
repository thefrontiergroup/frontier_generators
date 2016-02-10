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
  def to_s(includes_bang=false)
    "let#{includes_bang ? "!" : nil}(:#{key}) { #{body} }"
  end

end
