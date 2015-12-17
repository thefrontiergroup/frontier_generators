class Frontier::Controller::AuthorizeScope

  attr_reader :model_configuration

  def initialize(model_configuration)
    @model_configuration = model_configuration
  end

  def to_s
    if model_configuration.using_pundit?
      # policy_scope(User.all)
      "policy_scope(#{model_configuration.as_constant}.all)"
    else
      # For now, do not apply any scope to the collection
      # User.all
      "#{model_configuration.as_constant}.all"
    end
  end

end
