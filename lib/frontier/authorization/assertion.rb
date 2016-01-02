class Frontier::Authorization::Assertion

  attr_reader :action, :model_configuration

  def initialize(model_configuration, action)
    @model_configuration = model_configuration
    @action = action
  end

  def to_s
    if model_configuration.using_pundit?
      # Pundit will infer the action from the controller action being used, so there is
      # no reason to pass it through.
      #
      # authorize(User)
      "authorize(#{model_configuration.as_constant})"
    else
      if action.to_sym == :index
        # Index action should be authorized against the class
        # authorize!(:index, User)
        "authorize!(:#{action}, #{model_configuration.as_constant})"
      else
        # All other actions should be authorized against the instance
        # authorize!(:new, @user)
        "authorize!(:#{action}, #{model_configuration.as_ivar_instance})"
      end
    end
  end

end
