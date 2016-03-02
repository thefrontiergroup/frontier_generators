class Frontier::Authorization::Check

  attr_reader :action, :authorizable_object, :model_configuration

  def initialize(model_configuration, authorizable_object, action)
    @action = action
    @authorizable_object = authorizable_object
    @model_configuration = model_configuration
  end

  def to_s
    if model_configuration.using_pundit?
      # policy(User).new?
      "policy(#{authorizable_object}).#{action}?"
    else
      # can?(:new, User)
      "can?(:#{action}, #{authorizable_object})"
    end
  end

end
