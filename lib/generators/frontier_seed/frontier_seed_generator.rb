require_relative "../../frontier"

class FrontierSeedGenerator < Frontier::Generator
  source_root File.expand_path('../templates', __FILE__)

  def scaffold
    template("seed.rake", "lib/tasks/seeds/#{model.name.as_collection}.rake")
  end

end
