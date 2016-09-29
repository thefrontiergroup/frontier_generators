class Frontier::Authorization::Check

  attr_reader :action, :authorizable_object, :model

  def initialize(model, authorizable_object, action)
    @action = action
    @authorizable_object = authorizable_object
    @model = model
  end

  def to_s
    if model.using_pundit?
      # policy(User).new?
      "policy(#{authorizable_object}).#{action}?"
    else
      # can?(:new, User)
      "can?(:#{action}, #{authorizable_object})"
    end
  end

end
