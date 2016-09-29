class Frontier::Model::Name

  # model_name will be lower case singular: EG: "user_preference"
  def initialize(model_name)
    @model_name = model_name
  end

  # "user_preferences"
  def as_collection
    as_singular.pluralize
  end

  # "user_preference"
  def as_singular
    model_name
  end

  # "user preference"
  def as_singular_with_spaces
    as_singular.gsub("_", " ")
  end

  # "UserPreference"
  def as_constant
    "#{as_singular.camelize}"
  end

  # "@user_preferences"
  def as_ivar_collection
    "@#{as_collection}"
  end

  # "@user_preference"
  def as_ivar_instance
    "@#{as_singular}"
  end

  # ":user_preference"
  def as_symbol
    ":#{as_singular}"
  end

  # ":user_preferences"
  def as_symbol_collection
    ":#{as_collection}"
  end

  # "User Preference"
  def as_title
    as_singular.titleize
  end

private

  attr_reader :model_name

end
