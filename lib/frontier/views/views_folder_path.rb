class Frontier::Views::ViewsFolderPath

  include Frontier::ModelProperty

  def to_s
    File.join(
      "app",
      "views",
      *model.controller_prefixes.map(&:as_snake_case),
      model.name.as_plural
    ).to_s
  end

end
