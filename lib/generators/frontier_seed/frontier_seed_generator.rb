require_relative "../../generator"

class FrontierSeedGenerator < Frontier::Generator
  source_root File.expand_path('../templates', __FILE__)

  def scaffold
    template("seed.rake", "lib/tasks/seeds/#{model_configuration.model_name.pluralize}.rake")
  end

end
