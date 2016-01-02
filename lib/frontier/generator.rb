class Frontier::Generator < Rails::Generators::NamedBase

  attr_reader :model_configuration

  def initialize(args, *options)
    super

    @model_configuration = build_model_configuration(args[0])
  end

private

  def build_model_configuration(file_path)
    if file_path.present?
      ModelConfiguration::YamlParser.new(file_path).model_configuration
    else
      # TODO: Error handling!
    end
  end

end
