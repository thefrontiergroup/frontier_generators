require_relative "../../model_configuration/model_configuration"

class FrontierSeedGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  attr_accessor :model_configuration

  def scaffold
    self.model_configuration = ModelConfiguration::YamlParser.new(ARGV[0]).model_configuration

    template("seed.rake", "lib/tasks/seeds/#{model_configuration.model_name.pluralize}.rake")
  end

end
