class Frontier::Views::ViewsFolderPath

  include Frontier::ModelProperty

  def to_s
    File.join(
      "app",
      "views",
      *model.controller_prefixes.map(&:as_snake_case),
      model.model_name.pluralize
    ).to_s
  end

end
