class Frontier::YamlParser

  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def model
    parsed_yaml = YAML.load(File.open(file_path))
    if parsed_yaml.keys.count > 1
      raise(ArgumentError, "Multiple models currently not supported")
    else
      Frontier::Model.new(parsed_yaml.with_indifferent_access)
    end
  end

end
