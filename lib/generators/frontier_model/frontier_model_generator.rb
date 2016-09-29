require_relative "../../frontier"

class FrontierModelGenerator < Frontier::Generator
  source_root File.expand_path('../templates', __FILE__)

  def scaffold
    unless model.skip_seeds?
      # Generate seed files for the model
      generate("frontier_seed", ARGV[0])
    end

    unless model.skip_model?
      generate("migration", Frontier::MigrationStringBuilder.new(model).to_s)
      template("model.rb", "app/models/#{model.model_name}.rb")
      template("model_spec.rb", "spec/models/#{model.model_name}_spec.rb")
    end
    unless model.skip_factory?
      template("factory.rb", "spec/factories/#{model.model_name.pluralize}.rb")
    end
  end
end
