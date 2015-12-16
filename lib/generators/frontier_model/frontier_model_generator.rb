require_relative "../../model_configuration/model_configuration"
require_relative "../../support/migration_string_builder"

class FrontierModelGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  attr_accessor :model_configuration

  def scaffold
    self.model_configuration = ModelConfiguration::YamlParser.new(ARGV[0]).model_configuration

    unless model_configuration.skip_seeds
      # Generate seed files for the model
      generate("frontier_seed", ARGV[0])
    end

    unless model_configuration.skip_model
      generate("migration", MigrationStringBuilder.new(model_configuration).to_s)
      template("model.rb", "app/models/#{model_configuration.model_name}.rb")
      template("model_spec.rb", "spec/models/#{model_configuration.model_name}_spec.rb")
    end
    unless model_configuration.skip_factory
      template("factory.rb", "spec/factories/#{model_configuration.model_name.pluralize}.rb")
    end
  end
end
