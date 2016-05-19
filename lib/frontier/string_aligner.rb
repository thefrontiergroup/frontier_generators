class Frontier::StringAligner

  attr_reader :strings, :token

  def initialize(strings, token)
    @strings = strings
    @token = token
  end

  def aligned
    strings.map(&method(:align_string))
  end

private

  def align_string(string)
    if string.include?(token)
      before, *after = string.split(token)
      [before.ljust(furthest_rindex_of_token, " "), token, after.join(token)].join
    else
      string
    end
  end

  def furthest_rindex_of_token
    strings.map {|string| string.index(token) || 0}.max
  end

end
