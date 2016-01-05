class Frontier::Generator < Rails::Generators::NamedBase

  attr_reader :model_configuration

  def initialize(args, *options)
    # We need this to run before super. If the args are nil (ie: no config file is passed through)
    # super will raise a different kind of exception that doesn't make it clear why the generator
    # failed.
    @model_configuration = build_model_configuration(args[0])
    super
  end

private

  def build_model_configuration(file_path)
    if file_path.present?
      parse_model_configuration(file_path)
    else
      raise(ArgumentError, "No file path passed through. Please pass the path to a YML file through.")
    end
  end

  def parse_model_configuration(file_path)
    if File.exists?(file_path)
      Frontier::YamlParser.new(file_path).model_configuration
    else
      raise(ArgumentError, "No file exists for path: #{file_path}")
    end
  end

end
