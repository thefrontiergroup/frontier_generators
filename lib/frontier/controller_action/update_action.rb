class Frontier::ControllerAction::UpdateAction

  attr_reader :model_configuration

  def initialize(model_configuration)
    @model_configuration = model_configuration
  end

  ##
  # Renders the update action for a controller. EG:
  #
  # def update
  #   @user = find_user
  #   @user.assign_attributes(strong_params_for(User))
  #   @user.save if authorize(@user)
  #
  #   respond_with(@user, location: admin_users_path)
  # end
  #
  def to_s
    raw = <<-STRING
def update
  #{model_configuration.as_ivar_instance} = find_#{model_configuration.model_name}
  #{model_configuration.as_ivar_instance}.assign_attributes(strong_params_for(#{model_configuration.as_constant}))
  #{model_configuration.as_ivar_instance}.save if #{Frontier::Authorization::Assertion.new(model_configuration, :update).to_s}

  respond_with(#{model_configuration.as_ivar_instance}, location: #{model_configuration.url_builder.index_path})
end
STRING
    raw.rstrip
  end

end
