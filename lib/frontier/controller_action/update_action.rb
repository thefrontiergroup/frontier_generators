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
  #{model.name.as_ivar_instance} = find_#{model.name.as_singular}
  #{model.name.as_ivar_instance}.assign_attributes(strong_params_for_#{model.name.as_singular})
  #{Frontier::Authorization::Assertion.new(model, :update).to_s}
  #{model.name.as_ivar_instance}.save

  respond_with(#{model.name.as_ivar_instance}, location: #{model.url_builder.index_path})
end
STRING
    raw.rstrip
  end

end
