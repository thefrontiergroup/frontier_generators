class ModelConfiguration::Attribute::Validation

  attr_reader :attribute, :key, :args

  # EG:
  # attribute: name
  # key: presence
  # args: true OR {message: "YOLO"}
  def initialize(attribute, key, args)
    @attribute = attribute
    @key = key
    @args = args
  end

  def implementation
    "#{key}: #{args}"
  end

end