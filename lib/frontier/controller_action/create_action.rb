class Frontier::ControllerAction::CreateAction

  include Frontier::ModelConfigurationProperty

  ##
  # Renders the create action for a controller. EG:
  #
  # def create
  #   @user = User.new(strong_params_for(User))
  #   @user.save if authorize(@user)
  #
  #   respond_with(@user, location: admin_users_path)
  # end
  #
  def to_s
    raw = <<-STRING
def create
  #{model_configuration.as_ivar_instance} = #{model_configuration.as_constant}.new(strong_params_for_#{model_configuration.model_name})
  #{Frontier::Authorization::Assertion.new(model_configuration, :create).to_s}
  #{model_configuration.as_ivar_instance}.save

  respond_with(#{model_configuration.as_ivar_instance}, location: #{model_configuration.url_builder.index_path})
end
STRING
    raw.rstrip
  end

end
