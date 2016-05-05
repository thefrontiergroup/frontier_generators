require_relative "../../frontier"

class FrontierModelGenerator < Frontier::Generator
  source_root File.expand_path('../templates', __FILE__)

  def scaffold
    unless model_configuration.skip_seeds?
      # Generate seed files for the model
      generate("frontier_seed", ARGV[0])
    end

    unless model_configuration.skip_model?
      generate("migration", Frontier::MigrationStringBuilder.new(model_configuration).to_s)
      template("model.rb", "app/models/#{model_configuration.model_name}.rb")
      template("model_spec.rb", "spec/models/#{model_configuration.model_name}_spec.rb")
    end
    unless model_configuration.skip_factory?
      template("factory.rb", "spec/factories/#{model_configuration.model_name.pluralize}.rb")
    end
  end
end
