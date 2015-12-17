class Frontier::Authorization::Check

  attr_reader :action, :model_configuration

  def initialize(model_configuration, action)
    @model_configuration = model_configuration
    @action = action
  end

  def to_s
    if model_configuration.using_pundit?
      if action.to_sym == :new
        # policy(User).new?
        "policy(#{model_configuration.as_constant}).#{action}?"
      else
        # policy(@user).edit?
        "policy(#{model_configuration.as_ivar_instance}).#{action}?"
      end
    else
      if action.to_sym == :new
        # can?(:new, User)
        "can?(:#{action}, #{model_configuration.as_constant})"
      else
        # can?(:edit, @user)
        "can?(:#{action}, #{model_configuration.as_ivar_instance})"
      end
    end
  end

end
