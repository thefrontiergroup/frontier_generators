class Frontier::ControllerAction::UpdateAction

  include Frontier::ModelProperty

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
  #{model.as_ivar_instance} = find_#{model.model_name}
  #{model.as_ivar_instance}.assign_attributes(strong_params_for_#{model.model_name})
  #{Frontier::Authorization::Assertion.new(model, :update).to_s}
  #{model.as_ivar_instance}.save

  respond_with(#{model.as_ivar_instance}, location: #{model.url_builder.index_path})
end
STRING
    raw.rstrip
  end

end
